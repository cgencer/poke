﻿/*	CASA Lib for ActionScript 3.0	Copyright (c) 2009, Aaron Clinger & Contributors of CASA Lib	All rights reserved.		Redistribution and use in source and binary forms, with or without	modification, are permitted provided that the following conditions are met:		- Redistributions of source code must retain the above copyright notice,	  this list of conditions and the following disclaimer.		- Redistributions in binary form must reproduce the above copyright notice,	  this list of conditions and the following disclaimer in the documentation	  and/or other materials provided with the distribution.		- Neither the name of the CASA Lib nor the names of its contributors	  may be used to endorse or promote products derived from this software	  without specific prior written permission.		THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE	ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE	LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE	POSSIBILITY OF SUCH DAMAGE.*/package org.casalib.util {		/**		Utilities for manipulating and searching Strings.				@author Aaron Clinger		@author Mike Creighton		@author David Nelson		@version 02/10/09	*/	public class StringUtil {		public static const WHITESPACE:String = ' \n\t\r';		public static var SMALL_WORDS:Array   = new Array('a', 'an', 'and', 'as', 'at', 'but', 'by', 'en', 'for', 'if', 'in', 'of', 'on', 'or', 'the', 'to', 'v', 'via', 'vs');						/**			Transforms source String to title case.						@param source: String to return as title cased.			@param lowerCaseSmallWords: Indicates to make {@link #SMALL_WORDS small words} lower case {@code true}, or to capitalized small words {@code false}.			@return String with capitalized words.		*/		public static function toTitleCase(source:String, lowerCaseSmallWords:Boolean = true):String {			source = StringUtil._checkWords(source, ' ', true, lowerCaseSmallWords);						var parts:Array = source.split(' ');			var last:int    = parts.length - 1;						if (!StringUtil._isIgnoredWord(parts[0]))				parts[0] = StringUtil._capitalizeFirstLetter(parts[0]);						if (!StringUtil._isIgnoredWord(parts[last]))				parts[last] = StringUtil._capitalizeFirstLetter(parts[last]);						source = parts.join(' ');						if (StringUtil.contains(source, ': ')) {				var i:int = -1;				parts     = source.split(': ');								while (++i < parts.length)					parts[i] = StringUtil._capitalizeFirstLetter(parts[i]);								source = parts.join(': ');			}						return source;		}				protected static function _checkWords(source:String, delimiter:String, checkForDashes:Boolean = false, lowerCaseSmallWords:Boolean = false):String {			var words:Array = source.split(delimiter);			var l:int       = words.length;			var word:String;						while (l--) {				word = words[l];								words[l] = StringUtil._checkWord(word, checkForDashes, lowerCaseSmallWords);			}						return words.join(delimiter);		}				protected static function _checkWord(word:String, checkForDashes:Boolean, lowerCaseSmallWords:Boolean):String {			if (StringUtil._isIgnoredWord(word))				return word;						if (lowerCaseSmallWords)				if (StringUtil._isSmallWord(word))					return word.toLowerCase();						if (checkForDashes) {				var dashes:Array = new Array('-', '–', '—');				var i:int        = -1;				var dashFound:Boolean;								while (++i < dashes.length) {					if (StringUtil.contains(word, dashes[i]) != 0) {						word = StringUtil._checkWords(word, dashes[i], false, true);						dashFound = true;					}				}								if (dashFound)					return word;			}						return StringUtil._capitalizeFirstLetter(word);		}				protected static function _isIgnoredWord(word:String):Boolean {			var periodIndex:int = word.indexOf('.');			var upperIndex:int  = StringUtil.indexOfUpperCase(word);						if (periodIndex != -1 && periodIndex != word.length - 1 || upperIndex != -1 && upperIndex != 0)				return true;						return false;		}				protected static function _isSmallWord(word:String):Boolean {			var l:int = StringUtil.SMALL_WORDS.length;			word = StringUtil.getLettersFromString(word);						while (l--)				if (word.toLowerCase() == StringUtil.SMALL_WORDS[l])					return true;						return false;		}				protected static function _capitalizeFirstLetter(source:String):String {			var i:int = -1;			while (++i < source.length)				if (!StringUtil.isPunctuation(source.charAt(i)))					return StringUtil.replaceAt(source, i, source.charAt(i).toUpperCase());						return source;		}				/**			Determines if String is only comprised of punctuation characters (any character other than the letters or numbers).						@param source: String to check if punctuation.			@param allowSpaces: Indicates to count spaces as punctuation {@code true}, or not to {@code false}.			@return Returns {@code true} if String is only punctuation; otherwise {@code false}.		*/		public static function isPunctuation(source:String, allowSpaces:Boolean = true):Boolean {			if (StringUtil.getNumbersFromString(source).length != 0 || StringUtil.getLettersFromString(source).length != 0)				return false;						if (!allowSpaces)				return source.split(' ').length == 1;						return true;		}				/**			Determines if String is only comprised of upper case letters.						@param source: String to check if upper case.			@return Returns {@code true} if String is only upper case characters; otherwise {@code false}.		*/		public static function isUpperCase(source:String):Boolean {			var letters:Array = source.split('');			var l:Number      = letters.length;						while (l--)				if (letters[l] != letters[l].toUpperCase())					return false;						return true;		}				/**			Determines if String is only comprised of lower case letters.						@param source: String to check if lower case.			@return Returns {@code true} if String is only lower case characters; otherwise {@code false}.		*/		public static function isLowerCase(source:String):Boolean {			var letters:Array = source.split('');			var l:Number      = letters.length;						while (l--)				if (letters[l] != letters[l].toLowerCase())					return false;						return true;		}				/**			Searches the String for an occurrence of an upper case letter.						@param source: String to search for a upper case letter.			@return The index of the first occurrence of a upper case letter or {@code -1}.		*/		public static function indexOfUpperCase(source:String, startIndex:uint = 0):int {			var letters:Array = source.split('');			var i:int         = startIndex - 1;						while (++i < letters.length)				if (letters[i] == letters[i].toUpperCase() && letters[i] != letters[i].toLowerCase())					return i;						return -1;		}				/**			Searches the String for an occurrence of a lower case letter.						@param source: String to search for a lower case letter.			@return The index of the first occurrence of a lower case letter or {@code -1}.		*/		public static function indexOfLowerCase(source:String, startIndex:uint = 0):int {			var letters:Array = source.split('');			var i:int         = startIndex - 1;						while (++i < letters.length)				if (letters[i] == letters[i].toLowerCase() && letters[i] != letters[i].toUpperCase())					return i;						return -1;		}				/**			Returns all the numeric characters from a String.						@param source: String to return numbers from.			@return String containing only numbers.		*/		public static function getNumbersFromString(source:String):String {			var pattern:RegExp = /[^0-9]/g;			return source.replace(pattern, '');		}				/**			Returns all the letter characters from a String.						@param source: String to return letters from.			@return String containing only letters.		*/		public static function getLettersFromString(source:String):String {			var pattern:RegExp = /[^A-Z^a-z]/g;			return source.replace(pattern, '');		}				/**			Determines if String contains search String.						@param source: String to search in.			@param search: String to search for.			@return Returns the frequency of the search term found in source String.		*/		public static function contains(source:String, search:String):uint {			var pattern:RegExp = new RegExp(search, 'g');			return source.match(pattern).length;		}				/**			Strips whitespace (or other characters) from the beginning of a String.						@param source: String to remove characters from.			@param removeChars: Characters to strip (case sensitive).			@return String with characters removed.		*/		public static function trimLeft(source:String, removeChars:String = StringUtil.WHITESPACE):String {			var pattern:RegExp = new RegExp('^[' + removeChars + ']+', '');			return source.replace(pattern, '');		}				/**			Strips whitespace (or other characters) from the end of a String.						@param source: String to remove characters from.			@param removeChars: Characters to strip (case sensitive).			@return String with characters removed.		*/		public static function trimRight(source:String, removeChars:String = StringUtil.WHITESPACE):String {			var pattern:RegExp = new RegExp('[' + removeChars + ']+$', '');			return source.replace(pattern, '');		}				/**			Strips whitespace (or other characters) from the beginning and end of a String.						@param source: String to remove characters from.			@param removeChars: Characters to strip (case sensitive).			@return String with characters removed.		*/		public static function trim(source:String, removeChars:String = StringUtil.WHITESPACE):String {			var pattern:RegExp = new RegExp('^[' + removeChars + ']+|[' + removeChars + ']+$', 'g');			return source.replace(pattern, '');		}				/**			Removes additional spaces from String.						@param source: String to remove extra spaces from.			@return String with additional spaces removed.		*/		public static function removeExtraSpaces(source:String):String {			var pattern:RegExp = /( )+/g;			return StringUtil.trim(source.replace(pattern, ' '), ' ');		}				/**			Removes tabs, linefeeds, carriage returns and spaces from String.						@param source: String to remove whitespace from.			@return String with whitespace removed.		*/		public static function removeWhitespace(source:String):String {			var pattern:RegExp = new RegExp('[ \n\t\r]', 'g');			return source.replace(pattern, '');		}				/**			Removes characters from a source String.						@param source: String to remove characters from.			@param remove: String describing characters to remove.			@return String with characters removed.		*/		public static function remove(source:String, remove:String):String {			return StringUtil.replace(source, remove, '');		}				/**			Replaces target characters with new characters.						@param source: String to replace characters from.			@param remove: String describing characters to remove.			@param replace: String to replace removed characters.			@return String with characters replaced.		*/		public static function replace(source:String, remove:String, replace:String):String {			var pattern:RegExp = new RegExp(remove, 'g');			return source.replace(pattern, replace);		}				/**			Removes a character at a specific index.						@param source: String to remove character from.			@param position: Position of character to remove.			@return String with character removed.		*/		public static function removeAt(source:String, position:int):String {			return StringUtil.replaceAt(source, position, '');		}				/**			Replaces a character at a specific index with new characters.						@param source: String to replace characters from.			@param position: Position of character to replace.			@param replace: String to replace removed character.			@return String with character replaced.		*/		public static function replaceAt(source:String, position:int, replace:String):String {			var parts:Array = source.split('');			parts.splice(position, 1, replace);			return parts.join('');		}				/**			Adds characters at a specific index.						@param source: String to add characters to.			@param position: Position in which to add characters.			@param addition: String to add.			@return String with characters added.		*/		public static function addAt(source:String, position:int, addition:String):String {			var parts:Array = source.split('');			parts.splice(position, 0, addition);			return parts.join('');		}				/**			Extracts all the unique characters from a source String.						@param source: String to find unique characters within.			@return String containing unique characters from source String.		*/		public static function getUniqueCharacters(source:String):String {			var unique:String = '';			var i:uint        = 0;			var char:String;						while (i < source.length) {				char = source.charAt(i);								if (unique.indexOf(char) == -1)					unique += char;								i++;			}						return unique;		}	}}