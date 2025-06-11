Return-Path: <linux-hyperv+bounces-5844-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F81AD4A8C
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 07:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F2AE7ABA35
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 05:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197F15336D;
	Wed, 11 Jun 2025 05:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RWoowtRw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DC5A923;
	Wed, 11 Jun 2025 05:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749620999; cv=none; b=u+Xy4eXQdNDr6n/bLVv+7sjk2itk0gv2BaPD0+q6gVE0LVQzy5UMgzYlCKyr1hJCeEE8dPnq3SKLVm4wxqI+UflCqqkOZUgdAPahMLQ74DU8hwz0P2tD6HFQhISY3ZvT2Fs7z68LAZfSfEmhGXvJWocRlVJsF6v69FZqSaBe7Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749620999; c=relaxed/simple;
	bh=1r+1Ub91oEVILJjyVMGAfNWwbExeRnoulgm+ojZt2jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AECm5CTIJ8wuYlZB/Ffmu1xJnF2c0S/Ykx9+Mc2OMGNKxr3lk/1SOLXvD4D+cPnhte+I5MdMQahrKQTfrgQmMxhuKttNomqOSwRNyYbG4rWDqd/QHeQMqlsPsk5ekabRf/8aHMTORJTUvLrCb9YlcS5HDgaG7ePYKyAp8Ge+utE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RWoowtRw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.97.102] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id BBD422078616;
	Tue, 10 Jun 2025 22:49:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BBD422078616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749620997;
	bh=VevsbnJHRRuP5aY2ayRtNEtVOJ4OCymlrJ9TPuVJxhM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RWoowtRwErNICeOGUIzcTDMmb9gRoWAEzjGmcVFNJAowOaWHB/woK894JebdbW5K1
	 8KAg0tjlbRTIqu5v5QDev11H0N6vC9p6xh0ZVQFE7FV2x6vXtXSaTN1VEWlCbTzPEP
	 cCrEBRQ3qm9UCZugnYX0dDMELmDrMJfOrJb01Ur0=
Message-ID: <59ff8eb7-36e9-4d11-98a1-ee94dc657f56@linux.microsoft.com>
Date: Wed, 11 Jun 2025 11:19:51 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] Drivers: hv: Export some symbols for mshv_vtl
To: kernel test robot <lkp@intel.com>, "K . Y . Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: oe-kbuild-all@lists.linux.dev, Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20250610052435.1660967-2-namjain@linux.microsoft.com>
 <202506110544.q0NDMQVc-lkp@intel.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <202506110544.q0NDMQVc-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/11/2025 3:27 AM, kernel test robot wrote:
> Closes:https://lore.kernel.org/oe-kbuild-all/202506110544.q0NDMQVc-lkp@intel.com/


I'll fix this, along with other warnings in Hyper-V drivers in next
version. Will share it shortly.

These are exposed after these recent changes:

commit 7d95680d64ac8e836c35fd56efe77eac4e9cc26b
Author: Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun Jun 1 22:31:30 2025 +0900

     scripts/misc-check: check unnecessary #include <linux/export.h> 
when W=1

commit a934a57a42f64a40705202f84144b1a29b29f910
Author: Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun Jun 1 22:31:29 2025 +0900

     scripts/misc-check: check missing #include <linux/export.h> when W=1


Regards,
Naman

