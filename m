Return-Path: <linux-hyperv+bounces-5761-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3E8ACDA9A
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 11:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 292587AA34C
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 09:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635D728C844;
	Wed,  4 Jun 2025 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9IKNrBU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBEB28A1F1
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Jun 2025 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028271; cv=none; b=lxAmnBsfGUrBZzdavJasx/Yw3TTZS5qHQfdIQg49mOvpCdW/L3/YWlU8BQRM21e6jT8jzMk1iTkFVMPRCVLABH3QT0DtMFKI3ojRIYDrY2mcr4i89Nbn1+3X7dY2xZA0J12bJDF3jsAQcTqnyXnm76t6Alge2W45HI1Y2JFuPk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028271; c=relaxed/simple;
	bh=spYDiOcng4ILQVWVlDPzfdbym7DybbFmVjx1dh2S4zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1e7qukOn4HeTz/A6KMqiXRaHZQx/QMJryati1mUBsGQVjxXa11N7C05ekmtRK6SbGeoRnsjLzB2GY15sNewpJ8J8ad+KI6CfkLt9cY3eXrMbqV+GfB5POnw3HWP8O7Opp476PbEwfvoJUtLLElwQBvaGN4tcFe4p8bVXkswU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9IKNrBU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235e1d710d8so5944825ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 04 Jun 2025 02:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749028269; x=1749633069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W8ku4T+OD0xT237A86iNX8WAPjdtmRoRfxA5+iN6PIc=;
        b=D9IKNrBUCW4o4KHvBh8BiULVU+2tDkC/0PNaz8SaIhfhcti6gYh2uvffGMktdO6FPg
         OV+X5JzkvaVnTX8bquog476fldp7mdFzNOHpoKdPBSX6G3y+Ojnl2nSo6KK09gTZp4pg
         yUeM1xdNcnqRkfYXvFxkb1XK7fD6sv/gBxwMYYyHJKsb6dmSPsweJrjW+R5kYR4/i5cm
         WSI+YIHQsCMVzGt2QIVJymEE0dCRZsZJEyZdUzugLvBXVRdKHIi/LN+qg109+2kCeGU2
         fh28BjaUN/6NdqNKpu4U2i1GUsLfe+Qh5ReWWixHHPZG7mTpTOqJNiLYfvh7oBtsMQ37
         b0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749028269; x=1749633069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8ku4T+OD0xT237A86iNX8WAPjdtmRoRfxA5+iN6PIc=;
        b=umsffihCqPZ9z4UZfJvL3SiF/d5rXtX06weke+BUam/xHa24xtQ9uYC3loyPIWV2lt
         bq4cANMjlR6P6F5VoWMSetFZuxj3imciz0OPGmuyYG038PcgivFsgHObevLj5NJ0vZFG
         gV6j/9ux0rH8yINooZrUeHaEmBy5TfB+FqsJ6Dx1PoZKeVtMX92QFIJRzNetxSNbaVRk
         olxR4Y5UY7+b2owT4SI9m2zniiS4S9Fze9z8dsB/5MTTQwykL6fjqr2XXRe7hBVSe+gq
         om6vi8OqHkZHP+MfxR4frJsTasDR+zm3CDl9Ozj6mDPi6RYie4Hc2eWcyf05fNuwxwN7
         /sdg==
X-Forwarded-Encrypted: i=1; AJvYcCUMQyHPBUq0DoVtIxfongqHURDu6gZW2XGzy74QsISX65f4P1JcFyddfRmlpPgPXB60zZ0sYmmsZFGdVbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxqEYekxx+tV2BxjCP0/nwBuEAVqf2Whx2gkZ8BuHIHPjafCpA
	fZ9elBjDFRSdtNFbbAv9C57MuyLbC72iBS+y+Pn8/GhPuul7aitIdyDE
X-Gm-Gg: ASbGnctOkJZOjWslArluLHD/IWHcmHiKMCC+IuDNOe7GuzzU2HA/I33xgEYk8TuiwKN
	ZoMU5TOIAiwIBpbXJKECIstn5STRp1AXjBcL46uqkLR95bdQmqlAt3v3hDFC2PqH4sowEiMHZOL
	K92SVvz1BxTkZMoNO4hDpThWMuZIeWnpl5GuGzLMIyJ0b6WT9B6sRKsfX3VvEfcpDp16BQ13+nm
	546VmpheVP2FeJ4xeZkNcJDxISrCq08jyVPB0p4Mb0gfVS/vw9ZMa7YNfemw4dmHf0YPX037GPs
	P8bcMkxUCa0cx8hs47/R/2VEQ7UzcjL3kwYner339YPRN8JhtdkSvRSkNeHuEflbPdVLYxdcKJW
	4MDspYlT0200Hv3bFAdP5lD2kSAyMdBZ3zYSH0LBR
X-Google-Smtp-Source: AGHT+IHC8yOuYEXvtPUaRyMyYPSKBzx/wxVorymqHM1knaDYbvUW1hDFGNPrtnhyQwL9xvuFwDrLRQ==
X-Received: by 2002:a17:902:e851:b0:234:d7b2:2ab2 with SMTP id d9443c01a7336-235e1195fe1mr24663355ad.8.1749028268557;
        Wed, 04 Jun 2025 02:11:08 -0700 (PDT)
Received: from ?IPV6:2400:4051:8da4:6b00:7185:1667:de1c:feec? ([2400:4051:8da4:6b00:7185:1667:de1c:feec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc889csm99925625ad.15.2025.06.04.02.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 02:11:08 -0700 (PDT)
Message-ID: <72f78577-ec5e-43a3-9378-a77e003b05a6@gmail.com>
Date: Wed, 4 Jun 2025 18:10:36 +0900
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] hv_fcopy_uio_daemon: Fix file copy failure between
 Windows host and Linux guest
To: Naman Jain <namjain@linux.microsoft.com>, eahariha@linux.microsoft.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, linux-hyperv@vger.kernel.org,
 ssengar@linux.microsoft.com
References: <e174e3b0-6b62-4996-9854-39c84e10a317@linux.microsoft.com>
 <20250603234300.1997-1-yasuenag@gmail.com>
 <20250603234300.1997-2-yasuenag@gmail.com>
 <581033c2-4ff4-44c8-a33c-02da3461fb51@linux.microsoft.com>
Content-Language: en-US
From: Yasumasa Suenaga <yasuenag@gmail.com>
In-Reply-To: <581033c2-4ff4-44c8-a33c-02da3461fb51@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Naman,
Sorry for bothering you, but I have some questions:


> 1. Create a new patch file for every new version and then send it.
> Currently it seems you are manually editing the same patch file in the
> subject and sending it, so each patch version is showing up in the same
> thread.

I've committed changes with "git amend" and created formatted patch with "git format-patch",
then I sent all of *.patch files via "git send-email".
Do you mean I should commit to fix commits reviewers and send cover letter and incremental
patches only? I couldn't find about it from the guide.
I checked linux-hyperv list, all of patches have been sent in each version AFAICS.


> 3. Keep a minimum of 1-2 weeks gap between successive patch versions to
> give time to people to review your changes.

Does it include changes of commit message too?


> 4. In the commit msg of v3, it is still not very clear what problem, you
> are trying to fix here. Do you mean to say that fcopy does not work on
> Linux? Or you are assuming it won't work and fixing some generic
> problem?
> Fcopy is supposed to work fine on Linux VM on HyperV with windows host. If there are some errors, please share in cover letter/comments
> in the patch along with steps of execution.

I have a problem on my PC:

   Host: Windows 11 Pro (24H2 build 26100.4202)
   Guest: Fedora 42
     - kernel-6.14.4-300.fc42.x86_64
     - hypervfcopyd-6.10-1.fc42.x86_64

How to reproduce: run Copy-VMFile commandlet on Host:

Following log is in Japanese because my PC is set to Japanese, sorry.
But it says fcopy could not transfer file (test.ps1) to /tmp/ on Linux guest because it already exists.
I confirmed /tmp/test.ps1 does not exist of course.

```
> Copy-VMFile

cmdlet Copy-VMFile at command pipeline position 1
Supply values for the following parameters:
Name[0]: Fedora42
Name[1]:
SourcePath: test.ps1
DestinationPath: /tmp/
FileSource: Host
Copy-VMFile: ゲストへのファイルのコピーを開始できませんでした。

ソース ファイル 'C:\test\test.ps1' をゲストの宛先 '/tmp/' にコピーできませんでした。

'Fedora42' はゲスト: ファイルがあります。 (0x80070050) へのファイルのコピーを開始できませんでした。(仮想マシン ID 9BFDF23D-CCAA-4748-A770-6D654E09A133)

'Fedora42' は、コピー元ファイル 'C:\test\test.ps1' をゲスト上のコピー先 '/tmp/' にコピーできませんでした: ファイルがあります。 (0x80070050)。(仮想マシン ID 9BFDF23D-CCAA-4748-A770-6D654E09A133)
```

I got following fcopy log from journald - it is strange because "/tmp/test.ps1" should be shown here.
```
6月 04 17:48:24 fc42 HV_UIO_FCOPY[1080]: File: / exists
```

As I wrote in commit message, wchar_t is 32 bit in Linux. I confirmed it with "sizeof(wchar_t)".
However fcopyd handles it as 16 bit value (__u16), thus I think this is a bug in fcopy, and
I think it would also not work on other environments.

Actually it works fine with my patch to handle values as 16 bit.


Thanks,

Yasumasa


On 2025/06/04 15:19, Naman Jain wrote:
> 
> 
> On 6/4/2025 5:13 AM, yasuenag@gmail.com wrote:
>> From: Yasumasa Suenaga <yasuenag@gmail.com>
>>
>> Handle file copy request from the host (e.g. Copy-VMFile commandlet)
>> correctly.
>> Store file path and name as __u16 arrays in struct hv_start_fcopy.
>> Convert directly to UTF-8 string without casting to wchar_t* in fcopyd.
>>
>> Fix string conversion failure caused by wchar_t size difference between
>> Linux (32bit) and Windows (16bit). Convert each character to char
>> if the value is less than 0x80 instead of using wcstombs() call.
>>
>> Add new check to snprintf() call for target path creation to handle
>> length differences between PATH_MAX (Linux) and W_MAX_PATH (Windows).
>>
>> Signed-off-by: Yasumasa Suenaga <yasuenag@gmail.com>
>> ---
>>   tools/hv/hv_fcopy_uio_daemon.c | 37 ++++++++++++++--------------------
>>   1 file changed, 15 insertions(+), 22 deletions(-)
>>
>> diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
>> index 0198321d1..86702f39e 100644
>> --- a/tools/hv/hv_fcopy_uio_daemon.c
>> +++ b/tools/hv/hv_fcopy_uio_daemon.c
>> @@ -62,8 +62,11 @@ static int hv_fcopy_create_file(char *file_name, char *path_name, __u32 flags)
>>       filesize = 0;
>>       p = path_name;
>> -    snprintf(target_fname, sizeof(target_fname), "%s/%s",
>> -         path_name, file_name);
>> +    if (snprintf(target_fname, sizeof(target_fname), "%s/%s",
>> +             path_name, file_name) >= sizeof(target_fname)) {
>> +        /* target file name is too long */
>> +        goto done;
>> +    }
>>       /*
>>        * Check to see if the path is already in place; if not,
>> @@ -273,6 +276,8 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
>>       while (len < dest_size) {
>>           if (src[len] < 0x80)
>>               dest[len++] = (char)(*src++);
>> +        else if (src[len] == '0')
>> +            break;
>>           else
>>               dest[len++] = 'X';
>>       }
>> @@ -282,27 +287,15 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
>>   static int hv_fcopy_start(struct hv_start_fcopy *smsg_in)
>>   {
>> -    setlocale(LC_ALL, "en_US.utf8");
>> -    size_t file_size, path_size;
>> -    char *file_name, *path_name;
>> -    char *in_file_name = (char *)smsg_in->file_name;
>> -    char *in_path_name = (char *)smsg_in->path_name;
>> -
>> -    file_size = wcstombs(NULL, (const wchar_t *restrict)in_file_name, 0) + 1;
>> -    path_size = wcstombs(NULL, (const wchar_t *restrict)in_path_name, 0) + 1;
>> -
>> -    file_name = (char *)malloc(file_size * sizeof(char));
>> -    path_name = (char *)malloc(path_size * sizeof(char));
>> -
>> -    if (!file_name || !path_name) {
>> -        free(file_name);
>> -        free(path_name);
>> -        syslog(LOG_ERR, "Can't allocate memory for file name and/or path name");
>> -        return HV_E_FAIL;
>> -    }
>> +    /*
>> +     * file_name and path_name should have same length with appropriate
>> +     * member of hv_start_fcopy.
>> +     */
>> +    char file_name[W_MAX_PATH], path_name[W_MAX_PATH];
>> -    wcstoutf8(file_name, (__u16 *)in_file_name, file_size);
>> -    wcstoutf8(path_name, (__u16 *)in_path_name, path_size);
>> +    setlocale(LC_ALL, "en_US.utf8");
>> +    wcstoutf8(file_name, smsg_in->file_name, W_MAX_PATH - 1);
>> +    wcstoutf8(path_name, smsg_in->path_name, W_MAX_PATH - 1);
>>       return hv_fcopy_create_file(file_name, path_name, smsg_in->copy_flags);
>>   }
> 
> Hi,
> I understand this is your first patch for upstreaming. Here are a few
> things you should consider:
> 1. Create a new patch file for every new version and then send it.
> Currently it seems you are manually editing the same patch file in the
> subject and sending it, so each patch version is showing up in the same
> thread.
> 2. Read, re-read, absorb the information in the link that Easwar also
> mentioned:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> 3. Keep a minimum of 1-2 weeks gap between successive patch versions to
> give time to people to review your changes.
> 4. In the commit msg of v3, it is still not very clear what problem, you
> are trying to fix here. Do you mean to say that fcopy does not work on
> Linux? Or you are assuming it won't work and fixing some generic
> problem?
> Fcopy is supposed to work fine on Linux VM on HyperV with windows host. If there are some errors, please share in cover letter/comments
> in the patch along with steps of execution.
> 
> 5. If its a fix, we should have a proper Fixes tag with the commit you
> are fixing.
> 6. Have a look at existing conversations at lore to get to know common
> practices with single patch, multi patch, cover letters etc.
> https://lore.kernel.org/linux-hyperv/?q=linux-hyperv
> 
> Regards,
> Naman
> 
> 


