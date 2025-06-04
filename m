Return-Path: <linux-hyperv+bounces-5766-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7DBACDE26
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 14:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C8207AAF81
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B15E13AD1C;
	Wed,  4 Jun 2025 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="F0RcrsyI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E3E28D8DD
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Jun 2025 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040623; cv=none; b=fSHBpw+d/zNhdxsC/AE070/5x0aQgH1H23FLSmpfyCzIL5+pITGF44q38G7jKYKdGw+UYUQp1hGngZZBcxl/tE+FL2/AKlWZGfVbMcKeLcKeriaxaVIxEqhOtAk3arqPELTv9l5ZXid4kQF0AnL3AT+zbN6EqGU2mRslmOTC9qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040623; c=relaxed/simple;
	bh=wBbODRp6IXYO1jc9kQR6bO1zdyy8Jpvx1VyGQN5AgIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJMiUqzJjKL/lRig32ECMDCgdntGjwD18NKQUK/uFRZDfhx1hgdFCOwZ3zKOpnVREicjeKDo7EFGBU2es4I4iMYydGJxljJeaHX5GRWIIy1vPrPajoC8ewujgbYsA6/2JjdwYgLeEikrVJfSE4YpKBPskMMDw2VGA+lfPkeWqbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=F0RcrsyI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.33.62] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id A92E8201FF2F;
	Wed,  4 Jun 2025 05:36:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A92E8201FF2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749040620;
	bh=74KggdhEHQeHsru25G+WuIEwdcEJbjAfWM5Qm+2+Tds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F0RcrsyImgNjsYz6PSLLOrYm0wokH17CJ7RqDcVESmeCqrHgwJYYcwowFC3Eo9Ks5
	 ywlT0HNZkt6Cs6AqyGY1hnr4NiyYb1b3FB+HuQK/hAGYVGJxVatpUXxUBBCyUcSmQV
	 wt7IzYlTlfmEXmBDe5vt+B0FQV+Dq++RtJrzIG8Q=
Message-ID: <fe8524f6-3f5f-4266-b9e5-f200ba04e1a9@linux.microsoft.com>
Date: Wed, 4 Jun 2025 18:06:56 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] hv_fcopy_uio_daemon: Fix file copy failure between
 Windows host and Linux guest
To: Yasumasa Suenaga <yasuenag@gmail.com>, eahariha@linux.microsoft.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, linux-hyperv@vger.kernel.org,
 ssengar@linux.microsoft.com
References: <e174e3b0-6b62-4996-9854-39c84e10a317@linux.microsoft.com>
 <20250603234300.1997-1-yasuenag@gmail.com>
 <20250603234300.1997-2-yasuenag@gmail.com>
 <581033c2-4ff4-44c8-a33c-02da3461fb51@linux.microsoft.com>
 <72f78577-ec5e-43a3-9378-a77e003b05a6@gmail.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <72f78577-ec5e-43a3-9378-a77e003b05a6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/4/2025 2:40 PM, Yasumasa Suenaga wrote:
> Hi Naman,
> Sorry for bothering you, but I have some questions:
> 
> 

Hi,
Happy to help. I have tested your patch on my setup, and it did not 
break anything for me. Please find response and additional questions inline.


>> 1. Create a new patch file for every new version and then send it.
>> Currently it seems you are manually editing the same patch file in the
>> subject and sending it, so each patch version is showing up in the same
>> thread.
> 
> I've committed changes with "git amend" and created formatted patch with 
> "git format-patch",
> then I sent all of *.patch files via "git send-email".
> Do you mean I should commit to fix commits reviewers and send cover 
> letter and incremental
> patches only? I couldn't find about it from the guide.
> I checked linux-hyperv list, all of patches have been sent in each 
> version AFAICS.
> 

* make changes
* git add, git commit, git format-patch, git send-email <path to v1 patch)
* make changes for v2
* git add, git commit --amend, git format-patch -v2, git send-email 
<path to v2 patch *only*>
and so on.

I follow above practice, and the patches go in new threads. I am not 
sure why they are landing in same thread for you. Anyhow, its not a big 
thing.

> 
>> 3. Keep a minimum of 1-2 weeks gap between successive patch versions to
>> give time to people to review your changes.
> 
> Does it include changes of commit message too?

Other reviewers may be reviewing older versions and it becomes confusing 
if new versions come too soon. To give everyone enough time to review 
your changes and to not have unnecessary patch versions, its better to 
wait for a few days, collect the feedback and address it together. We 
also need to mention what we changed since last time, to help reviewers 
know if their comments got addressed.

For single patch, we usually don't add a cover letter. You can refer
https://lore.kernel.org/all/20250102145243.2088-1-namjain@linux.microsoft.com/
The comments between the two "---" does not make it to git log.

> 
> 
>> 4. In the commit msg of v3, it is still not very clear what problem, you
>> are trying to fix here. Do you mean to say that fcopy does not work on
>> Linux? Or you are assuming it won't work and fixing some generic
>> problem?
>> Fcopy is supposed to work fine on Linux VM on HyperV with windows 
>> host. If there are some errors, please share in cover letter/comments
>> in the patch along with steps of execution.
> 
> I have a problem on my PC:
> 
>    Host: Windows 11 Pro (24H2 build 26100.4202)
>    Guest: Fedora 42
>      - kernel-6.14.4-300.fc42.x86_64
>      - hypervfcopyd-6.10-1.fc42.x86_64
> 
> How to reproduce: run Copy-VMFile commandlet on Host:
> 
> Following log is in Japanese because my PC is set to Japanese, sorry.
> But it says fcopy could not transfer file (test.ps1) to /tmp/ on Linux 
> guest because it already exists.
> I confirmed /tmp/test.ps1 does not exist of course.
> 
> ```
>> Copy-VMFile
> 
> cmdlet Copy-VMFile at command pipeline position 1
> Supply values for the following parameters:
> Name[0]: Fedora42
> Name[1]:
> SourcePath: test.ps1
> DestinationPath: /tmp/
> FileSource: Host
> Copy-VMFile: ゲストへのファイルのコピーを開始できませんでした。
> 
> ソース ファイル 'C:\test\test.ps1' をゲストの宛先 '/tmp/' にコピーできま 
> せんでした。
> 
> 'Fedora42' はゲスト: ファイルがあります。 (0x80070050) へのファイルのコ 
> ピーを開始できませんでした。(仮想マシン ID 9BFDF23D-CCAA-4748- 
> A770-6D654E09A133)
> 
> 'Fedora42' は、コピー元ファイル 'C:\test\test.ps1' をゲスト上のコピー先 
> '/tmp/' にコピーできませんでした: ファイルがあります。 (0x80070050)。(仮 
> 想マシン ID 9BFDF23D-CCAA-4748-A770-6D654E09A133)
> ```
> 
> I got following fcopy log from journald - it is strange because "/tmp/ 
> test.ps1" should be shown here.
> ```
> 6月 04 17:48:24 fc42 HV_UIO_FCOPY[1080]: File: / exists
> ```
> 
> As I wrote in commit message, wchar_t is 32 bit in Linux. I confirmed it 
> with "sizeof(wchar_t)".
> However fcopyd handles it as 16 bit value (__u16), thus I think this is 
> a bug in fcopy, and
> I think it would also not work on other environments.
> 
> Actually it works fine with my patch to handle values as 16 bit.
> 
> 
> Thanks,
> 
> Yasumasa
> 
> 
> On 2025/06/04 15:19, Naman Jain wrote:
>>
>>
>> On 6/4/2025 5:13 AM, yasuenag@gmail.com wrote:
>>> From: Yasumasa Suenaga <yasuenag@gmail.com>
>>>
>>> Handle file copy request from the host (e.g. Copy-VMFile commandlet)
>>> correctly.
>>> Store file path and name as __u16 arrays in struct hv_start_fcopy.
>>> Convert directly to UTF-8 string without casting to wchar_t* in fcopyd.
>>>
>>> Fix string conversion failure caused by wchar_t size difference between
>>> Linux (32bit) and Windows (16bit). Convert each character to char
>>> if the value is less than 0x80 instead of using wcstombs() call.
>>>
>>> Add new check to snprintf() call for target path creation to handle
>>> length differences between PATH_MAX (Linux) and W_MAX_PATH (Windows).
>>>
>>> Signed-off-by: Yasumasa Suenaga <yasuenag@gmail.com>
>>> ---
>>>   tools/hv/hv_fcopy_uio_daemon.c | 37 ++++++++++++++--------------------
>>>   1 file changed, 15 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/ 
>>> hv_fcopy_uio_daemon.c
>>> index 0198321d1..86702f39e 100644
>>> --- a/tools/hv/hv_fcopy_uio_daemon.c
>>> +++ b/tools/hv/hv_fcopy_uio_daemon.c
>>> @@ -62,8 +62,11 @@ static int hv_fcopy_create_file(char *file_name, 
>>> char *path_name, __u32 flags)
>>>       filesize = 0;
>>>       p = path_name;
>>> -    snprintf(target_fname, sizeof(target_fname), "%s/%s",
>>> -         path_name, file_name);
>>> +    if (snprintf(target_fname, sizeof(target_fname), "%s/%s",
>>> +             path_name, file_name) >= sizeof(target_fname)) {
>>> +        /* target file name is too long */

Please add a syslog for this. It will help in debugging issues.

>>> +        goto done;
>>> +    }
>>>       /*
>>>        * Check to see if the path is already in place; if not,
>>> @@ -273,6 +276,8 @@ static void wcstoutf8(char *dest, const __u16 
>>> *src, size_t dest_size)
>>>       while (len < dest_size) {
>>>           if (src[len] < 0x80)
>>>               dest[len++] = (char)(*src++);
>>> +        else if (src[len] == '0')
>>> +            break;

While this also works, I think you can add it to the while loop itself
while (len < dest_size && src[len])

Is this related to the FCopy issue that you see or this is just a fix 
for correct destination file name?


>>>           else
>>>               dest[len++] = 'X';
>>>       }
>>> @@ -282,27 +287,15 @@ static void wcstoutf8(char *dest, const __u16 
>>> *src, size_t dest_size)
>>>   static int hv_fcopy_start(struct hv_start_fcopy *smsg_in)
>>>   {
>>> -    setlocale(LC_ALL, "en_US.utf8");
>>> -    size_t file_size, path_size;
>>> -    char *file_name, *path_name;
>>> -    char *in_file_name = (char *)smsg_in->file_name;
>>> -    char *in_path_name = (char *)smsg_in->path_name;
>>> -
>>> -    file_size = wcstombs(NULL, (const wchar_t 
>>> *restrict)in_file_name, 0) + 1;
>>> -    path_size = wcstombs(NULL, (const wchar_t 
>>> *restrict)in_path_name, 0) + 1;
>>> -

Please help me understand if this is correct. The actual problem you are 
highlighting lies here when sizeof(wchat_t) is more than 16, i.e. 32?

>>> -    file_name = (char *)malloc(file_size * sizeof(char));
>>> -    path_name = (char *)malloc(path_size * sizeof(char));
>>> -
>>> -    if (!file_name || !path_name) {
>>> -        free(file_name);
>>> -        free(path_name);
>>> -        syslog(LOG_ERR, "Can't allocate memory for file name and/or 
>>> path name");
>>> -        return HV_E_FAIL;
>>> -    }
>>> +    /*
>>> +     * file_name and path_name should have same length with appropriate
>>> +     * member of hv_start_fcopy.
>>> +     */
>>> +    char file_name[W_MAX_PATH], path_name[W_MAX_PATH];
>>> -    wcstoutf8(file_name, (__u16 *)in_file_name, file_size);
>>> -    wcstoutf8(path_name, (__u16 *)in_path_name, path_size);
>>> +    setlocale(LC_ALL, "en_US.utf8");
>>> +    wcstoutf8(file_name, smsg_in->file_name, W_MAX_PATH - 1);
>>> +    wcstoutf8(path_name, smsg_in->path_name, W_MAX_PATH - 1);
>>>       return hv_fcopy_create_file(file_name, path_name, smsg_in- 
>>> >copy_flags);
>>>   }
>>
>> Hi,
>> I understand this is your first patch for upstreaming. Here are a few
>> things you should consider:
>> 1. Create a new patch file for every new version and then send it.
>> Currently it seems you are manually editing the same patch file in the
>> subject and sending it, so each patch version is showing up in the same
>> thread.
>> 2. Read, re-read, absorb the information in the link that Easwar also
>> mentioned:
>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>> 3. Keep a minimum of 1-2 weeks gap between successive patch versions to
>> give time to people to review your changes.
>> 4. In the commit msg of v3, it is still not very clear what problem, you
>> are trying to fix here. Do you mean to say that fcopy does not work on
>> Linux? Or you are assuming it won't work and fixing some generic
>> problem?
>> Fcopy is supposed to work fine on Linux VM on HyperV with windows 
>> host. If there are some errors, please share in cover letter/comments
>> in the patch along with steps of execution.
>>
>> 5. If its a fix, we should have a proper Fixes tag with the commit you
>> are fixing.
>> 6. Have a look at existing conversations at lore to get to know common
>> practices with single patch, multi patch, cover letters etc.
>> https://lore.kernel.org/linux-hyperv/?q=linux-hyperv
>>
>> Regards,
>> Naman
>>


Regards,
Naman
>>


