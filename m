Return-Path: <linux-hyperv+bounces-10440-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGiZIqDw8Gn9bAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10440-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:38:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D12648A144
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5902B3015E1E
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C96E44D013;
	Tue, 28 Apr 2026 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sTFMNTRY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047F444D014;
	Tue, 28 Apr 2026 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397851; cv=none; b=T0Zwz0di5SxBUyJtgUqe+AskFjVfQF57X2cIu+wrqsU0XWxEV0gEhyApMf5uZiOCtJ4TwTd7VmuwN219wW6L03UsKgj6y+896O4Y0MYrNcYWWUyjh2B7K4jRwhAAmJp+IgDG610r7KEPRO+bj9sGuuFrKXgMfmJogtF2OansTfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397851; c=relaxed/simple;
	bh=r2YM0wY1o2r6IwK1f66cqj7/D4ypxGsODLxRg+vuoSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osVRbXsBHQaw7mbfIGoH92V5T3ud/daqPzVSeEG1SV55DfL0gPetfK/NQ1Ng0luO08FrdgeVb+BJvD2mdHNN3G0QyZ+wuJPHuroz01b4uWaG11f59nWjIZN87HszJ9zEkG7YLsYYL6YYA6RoiKaBk9Up16JWCBf3hWS1FVDecSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sTFMNTRY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id F0E5D20B716C;
	Tue, 28 Apr 2026 10:37:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F0E5D20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777397849;
	bh=B5HeDN7LyTkUBtdQONLSYPM1kmKVQS+F0XuoHVbtdW0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sTFMNTRYJ4vvJk9Xxluf2YFxPMJotwiXeD1xZ6jjSEGQRXhkxcYFo3wi8E6gHUynF
	 0M7/e4BfhuG3Ih6qIsIP+Dr4eATNy/mELngWee64KCfaIYpbdD8NUtTxZg2jy+O7to
	 cYp7D23EcEfWDOrYW+Unn5QO0RJsy2e9ydxFaANA=
Message-ID: <d73822c0-dd72-6b33-81ad-ebd154300b81@linux.microsoft.com>
Date: Tue, 28 Apr 2026 10:37:27 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V1 08/13] PCI: hv: rename hv_compose_msi_msg to
 hv_vmbus_compose_msi_msg
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org, wei.liu@kernel.org,
 mhklinux@outlook.com, muislam@microsoft.com, namjain@linux.microsoft.com,
 magnuskulke@linux.microsoft.com, anbelski@linux.microsoft.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, longli@microsoft.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de
References: <20260428171451.GA233136@bhelgaas>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260428171451.GA233136@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0D12648A144
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10440-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]

On 4/28/26 10:14, Bjorn Helgaas wrote:
> On Mon, Apr 27, 2026 at 07:22:12PM -0700, Mukesh R wrote:
>> On 4/27/26 09:31, Bjorn Helgaas wrote:
>>> On Tue, Apr 21, 2026 at 07:32:34PM -0700, Mukesh R wrote:
>>>> Main change here is to rename hv_compose_msi_msg to
>>>> hv_vmbus_compose_msi_msg as we introduce hv_compose_msi_msg in upcoming
>>>> patches that builds MSI messages for both VMBus and non-VMBus cases. VMBus
>>>> is not used on baremetal root partition for example. While at it, replace
>>>> spaces with tabs and fix some formatting involving excessive line wraps.
>>>
>>> Would be better to do the whitespace changes in their own patch,
>>> although several of them should just be dropped (see below).
> 
>>>> - * facilities.  For instance, the configuration space of a function exposed
>>>> + * facilities.	For instance, the configuration space of a function exposed
>>>
>>> Oops, this hunk made it worse.  Definitely don't want a tab there.
> 
>>>> -		 * The vector we select here is a dummy value.  The correct
>>>> +		 * The vector we select here is a dummy value.	The correct
>>>
>>> Another tab that should be a space.  Actually, you should just drop
>>> this hunk; the rest of the comment has two spaces after periods, so
>>> this should too.
>>
>> well, most of our files does global replace 8 spaces with tabs, so
>> everywhere comments are well indented. Since, checkpatch doesn't complain
>> about tabs on comment lines, may I assue it is not a strict requirement
>> and more a nit or personal preference?
> 
> I guess I didn't make it clear.  I'm not complaining about leading
> tabs; I'm pointing out that the comments should not have embedded tabs
> in the middle between a period and the first word of the next
> sentence.

Oh, my bad, sorry, i didnt' realize that. Thank you, will def get rid
of them (most likely resulted from: vim %retab! command).

Thanks,
-Mukesh


> Here's what it looks like with "git show | cat -T":
> 
>    - * facilities.  For instance, the configuration space of a function exposed
>    + * facilities.^IFor instance, the configuration space of a function exposed
>                   ^^
> 
>    -^I^I * The vector we select here is a dummy value.  The correct
>    +^I^I * The vector we select here is a dummy value.^IThe correct
>                                                       ^^
> 
>    -^I^I * freed while we dereference the ring buffer pointer.  Test
>    +^I^I * freed while we dereference the ring buffer pointer.^ITest
>                                                               ^^
> 
>    -^I * to be overlapped by those children.  Set the flag on this claim
>    +^I * to be overlapped by those children.^ISet the flag on this claim
>                                             ^^
> 
> None of these hunks should be here.  Maybe some automation gone wrong?
> 
> In any case, every hunk of a patch that does "rename
> hv_compose_msi_msg to hv_vmbus_compose_msi_msg" should contain those
> names.  Any whitespace changes should be in their own patch so they
> don't make it hard to review the rename.


