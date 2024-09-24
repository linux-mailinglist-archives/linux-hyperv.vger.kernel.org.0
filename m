Return-Path: <linux-hyperv+bounces-3065-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED0A984ACE
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Sep 2024 20:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A51281DE5
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Sep 2024 18:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA001ABECA;
	Tue, 24 Sep 2024 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dk6pALFL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6334E11CA0;
	Tue, 24 Sep 2024 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727202177; cv=none; b=Y4drxIuHuoB08X/a+jt6GEcG5c3hCDQVToYDNXFqIfSHne4HBqwOFY6VFWpSHjz4VsLTZmbJHdK0q4WmBiX5Pt5LE2do5VK5NTtjabPWMPnotK+EwLMr7xUNj6N7qofuvxV0dDTJAvDWQusUPOY1gaKevN96UTmP5eA24mG2jF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727202177; c=relaxed/simple;
	bh=TUwq8CJ3h1KyuGejnrJdKWp5w35wORDJxiEqbkcXqnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EK9QwXiMtA2zwgTM8xScoanFL4+8hl4NdfxD6IT4MDB0QXp4JFwY3V6H0ZKpO45MJsV9QP0ARCSEGpuogx5b54O2F724g8OscASZdIRcGbG8YBJYNihQTuLW6hkf3Tma+TQ94vnZgN8l2xnHvlNiPzOdOh78aprSo1ZHJeSFBqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dk6pALFL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 17AB120C6497; Tue, 24 Sep 2024 11:22:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17AB120C6497
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727202170;
	bh=Sp511I3MRZE6mycvGCLM5CjDhuHrm3NCeyezfu9e2+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dk6pALFL+0XgJD6mtcKlYy+XqoazUImW8ZPyXrCT5YyZywaYLlvTmQHtKwubRRrdX
	 XFhofekAZSJATBqycvP+mI6/Ya8nd5jTS2KvGoH8Ni+b5kd7gk999Y5cB3DchYoBJQ
	 0ik1rCzIMNu+KuOH17sZ1QvECYIbA6wZK1z/ctlQ=
Date: Tue, 24 Sep 2024 11:22:50 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] tools: hv: Fix a complier warning in the fcopy uio daemon
Message-ID: <20240924182250.GA14242@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240910004433.50254-1-decui@microsoft.com>
 <20240913073058.GA24840@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SA1PR21MB13172712A02F3C9EEB156131BF6D2@SA1PR21MB1317.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB13172712A02F3C9EEB156131BF6D2@SA1PR21MB1317.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sat, Sep 21, 2024 at 01:23:09AM +0000, Dexuan Cui wrote:
> > From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
> > Sent: Friday, September 13, 2024 12:31 AM
> > To: Dexuan Cui <decui@microsoft.com>
> > Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Long Li
> > <longli@microsoft.com>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; open list:Hyper-V/Azure CORE AND DRIVERS
> > <linux-hyperv@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>;
> > stable@vger.kernel.org
> > Subject: Re: [PATCH] tools: hv: Fix a complier warning in the fcopy uio
> > daemon
> > 
> > On Tue, Sep 10, 2024 at 12:44:32AM +0000, Dexuan Cui wrote:
> > > hv_fcopy_uio_daemon.c:436:53: warning: '%s' directive output may be
> > truncated
> > > writing up to 14 bytes into a region of size 10 [-Wformat-truncation=]
> > >   436 |  snprintf(uio_dev_path, sizeof(uio_dev_path), "/dev/%s",
> > uio_name);
> > 
> > Makefile today doesn't have -Wformat-truncation flag enabled, I tried to add
> > -Wformat-truncation=2 but I don't see any error in this file.
> > 
> > Do you mind sharing more details how you get this error ?
> > 
> > - Saurabh
> 
> This repros in a Ubuntu 20.04 VM:
> 
> root@decui-u2004-2024-0920:~/linux/tools/hv# cat /etc/os-release
> NAME="Ubuntu"
> VERSION="20.04.6 LTS (Focal Fossa)"
> ...
> 
> root@decui-u2004-2024-0920:~/linux/tools/hv# gcc --version
> gcc (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0
> Copyright (C) 2019 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> root@decui-u2004-2024-0920:~/linux/tools/hv# make clean; make
> ...
> make -f /root/linux/tools/build/Makefile.build dir=. obj=hv_fcopy_uio_daemon
> make[1]: Entering directory '/root/linux/tools/hv'
>   CC      hv_fcopy_uio_daemon.o
> hv_fcopy_uio_daemon.c: In function 'main':
> hv_fcopy_uio_daemon.c:443:53: warning: '%s' directive output may be truncated writing up to 14 bytes into a region of size 10 [-Wformat-truncation=]
>   443 |  snprintf(uio_dev_path, sizeof(uio_dev_path), "/dev/%s", uio_name);
>       |                                                     ^~   ~~~~~~~~
> In file included from /usr/include/stdio.h:867,
>                  from hv_fcopy_uio_daemon.c:20:
> /usr/include/x86_64-linux-gnu/bits/stdio2.h:67:10: note: '__builtin___snprintf_chk' output between 6 and 20 bytes into a destination of size 15
>    67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    68 |        __bos (__s), __fmt, __va_arg_pack ());
>       |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   CC      vmbus_bufring.o
>   LD      hv_fcopy_uio_daemon-in.o
> make[1]: Leaving directory '/root/linux/tools/hv'
>   LINK    hv_fcopy_uio_daemon

Thanks for the details. Looks this is the behaviour of old gcc versions.
How about fixing it like this :

--- a/tools/hv/hv_fcopy_uio_daemon.c
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -35,7 +35,7 @@
 #define WIN8_SRV_MINOR         1
 #define WIN8_SRV_VERSION       (WIN8_SRV_MAJOR << 16 | WIN8_SRV_MINOR)

-#define MAX_FOLDER_NAME                15
+#define MAX_FOLDER_NAME                10
 #define MAX_PATH_LEN           15


- Saurabh


