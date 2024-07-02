Return-Path: <linux-hyperv+bounces-2517-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EC6923A0B
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jul 2024 11:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECFE28154C
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jul 2024 09:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9937153581;
	Tue,  2 Jul 2024 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJ54Dqsb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BDD1552E1
	for <linux-hyperv@vger.kernel.org>; Tue,  2 Jul 2024 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912605; cv=none; b=pMAH8QZyzabJHQq3BMHt/aE0MKnracjRP/nCT9jg2A9yk5tavPmL4mdsyQ6hXo71mgFZZITYSP6dbMyvdl0ojoopaBkNNFa4AMpLGwUhUf0V9yJQw8h+cKXNNCBOKoVLJf1LwBHHmvyJOk2ZmXvTxp9XY+VVMXWjmv5AYVAv23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912605; c=relaxed/simple;
	bh=fe5OaoAiPrPPLZpJbNIBC2Acj8ekKXnppBmVmR6n4yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXQE7K4JiELcNmcwH33M7lGmLRZRn9SfIemurbQ3pORiJmKqhXCSURWBePiu0IO/keFfLneMnX8bKAEvQZ9WLDRZaLjn37BBov/AFvEsbDUbnTvHxdq+VIn7MlVGwgf5SSHUHkLBC5Ao0VT5EWEmBJHpQn8VgDtlW6hpcKw5TSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJ54Dqsb; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79d90e01b30so111609985a.2
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Jul 2024 02:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719912603; x=1720517403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WBct9+EHNhGWWeMvblmKzY8nVlQFREvRGWt4d9afvng=;
        b=gJ54Dqsb6vm28KwVgYxLy9w4ActNXjdiCqNgO3sPuY9c0QbJbuS5KbkRbhzWi047EM
         aHuVuarHorux1YUyDyS0GgDy+dA2tSREqSBgBdH4nBBNmqzzblC5iytIKuMpk6RyDm5Z
         HGVR+xXn3ZLqqZbvwZPyF43YmmFVDJEBglnHghE4ipXGrDtUc7SVnakznR121yWbqKJ1
         BoR8GfwI1Gbz+aybt4AUyKaFarcITSEBBLYf9t2qvM9i2hax46I+k72xPY7Q76ODPhO9
         e1UW3BsUv9s5IWvjbrC0g+WRCYC92hrpXfc6pvtQMQCBxwQ/HYSb8IgSX19qFF6rASkV
         aQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719912603; x=1720517403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBct9+EHNhGWWeMvblmKzY8nVlQFREvRGWt4d9afvng=;
        b=qjgeC2wV4+kmjOOOXl4eCPFbAfBPm+RMFBWAhF4luM5xXU8S+csTS1W/iUd9xntlWJ
         TtW52JCwHjpT8E8KlpvRdW5aBjbyogwMgne6pzWBsbf2gYaiADlWTs0CSYQFNnUwMWY2
         473ldUB7ib7iXhxg+Mn/R1AhSivVyUGz6PPjoQc0uIqdhp4Xixxy7EDUt+YksNaXF//l
         Xe1n9XqWGeowdu8ZMxXGBHVl5/4fd77Rgzstd78JE5miIdTEZ/4X/eudrwucBDpUm0Lp
         7JBaOTzGsoGFkWVaFAcRwocZ1zSd9T6l/j2QozqHuIJd11Fsbne8DTSFtYeMCs6GJhwi
         ZGfw==
X-Gm-Message-State: AOJu0YwCuUqSjsX7IUU1do8IDz0XJbauN47toBuS52JJMURNEI0Oaee7
	7Vh+nQ/Tx59jshky0xwVrXjV2ygRw/T0QkV4YEg15XZ3fwlKbXVnwRYCEDTCq0D7zrvcooDOLWG
	/PsWHYjaAgqHVd4c++V7FylydHLs=
X-Google-Smtp-Source: AGHT+IGcAAuooud06AqzpBnpw7x4nJnqthz2lROixTC4VTgxclM/F9pubhdIC06Pe5uz7VFTGbzk/ctTKbHIGmiBSpg=
X-Received: by 2002:a05:6214:2129:b0:6a0:c903:7226 with SMTP id
 6a1803df08f44-6b5b70cad0emr106759106d6.34.1719912602939; Tue, 02 Jul 2024
 02:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701083554.11967-1-profnandaa@gmail.com> <SN6PR02MB4157668B1A29D9E0F5E01C77D4DC2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157668B1A29D9E0F5E01C77D4DC2@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Anthony Nandaa <profnandaa@gmail.com>
Date: Tue, 2 Jul 2024 12:29:52 +0300
Message-ID: <CAACuyFVaZz8vo57RPQmKv-HcuAwDnp3vMfhyw-PiEmHidrrDuw@mail.gmail.com>
Subject: Re: [PATCH] tools: hv: lsvmbus: change shebang to use python3
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"decui@microsoft.com" <decui@microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 06:15, Michael Kelley <mhklinux@outlook.com> wrote:
>
> From: Anthony Nandaa <profnandaa@gmail.com> Sent: Monday, July 1, 2024 1:36 AM
> >
> > This patch updates the shebang in the lsvmbus tool to use python3
> > instead of python. The change is necessary because Python 2 has
> > reached its end of life as of January 1, 2020, and is no longer
> > maintained[1]. Many modern systems do not have python pointing to
> > Python 2, and instead use python3.
> >
> > By explicitly using python3, we ensure compatibility with modern
> > systems since Python 2 is no longer being shipped by default.
> >
> > This change also updates the file permissions to make the script
> > executable, so that the script runs out of the box.
> > Also, similar scripts within `tools/hv` have mode `755`:
> >
> > ```
> > -rwxr-xr-x 1 labuser labuser   930 Jun 28 16:15 hv_get_dhcp_info.sh
> > -rwxr-xr-x 1 labuser labuser   622 Jun 28 16:15 hv_get_dns_info.sh
> > -rwxr-xr-x 1 labuser labuser  1888 Jun 28 16:15 hv_set_ifconfig.sh
> > ```
> >
> > Before fix, this is what you get when you attempt to run `lsvmbus`:
> > ```
> > /usr/bin/env: 'python': No such file or directory
> > ```
> >
>
> A note about commit message style. The guidelines in
> Documentation/process/submitting-patches.rst specifically say to
> use imperative mood and avoid "This patch" (and by extension,
> "This change"). For a patch that is fixing a problem, I usually
> describe the problem first, and then start a new paragraph with
> "Fix this problem by .....". So for your patch, I would suggest
> something like:
>
> In many modern Linux distros, running "lsvmbus" returns the error:
>
> /usr/bin/env: 'python': No such file or directory
>
> because 'python' doesn't point anywhere. Now that python2 has
> reached end of life as of January 1, 2020 and is no longer
> maintained[1], these distros have python3 instead. Also, the script
> isn't executable by default because the permissions are set to
> mode 644.
>
> Fix this by updating the shebang in the lsvmbus to use python3
> instead of python. Also fix the permissions to be 755 so that it is
> executable by default, which matches other similar scripts in tools/hv.
>
> Michael
Thanks Michael for the guidance. This is well noted and I'm going to fix
in my revision.

Regards,
Nandaa

