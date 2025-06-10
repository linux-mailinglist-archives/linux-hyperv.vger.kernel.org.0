Return-Path: <linux-hyperv+bounces-5825-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FEDAD3DCF
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 17:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799251892FC9
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 15:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC96F199EAD;
	Tue, 10 Jun 2025 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="EvKFBZKA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dzYY7pX7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043E47D098;
	Tue, 10 Jun 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570378; cv=none; b=hy+s8Zh/7hKsy68MZ+vBKR2HmoSRKqFyhwMzP8UQNHr03YW97j7VchaZN8NjfOZ6pzcI0ClB1njUZnkO/VDof/vV6g5yuqa5Q8reFU2Msa3J/t4jL/k/zaztzs6YJFV8zC5zi1PxLU1AN7A/+DE5UCYCm5ug2e2YI3K1Mb26sJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570378; c=relaxed/simple;
	bh=/w+J3Jyg+r+gCZOFLX3yqRPy0i117VGuFdXqxa9PPFM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VBWim91kfeId9ugkTLj+Zzeqz1tL7ITVupG1W7ETAOXkFGIoLrG8Q5ObNPRXuDsch2VYfoJ3GaclEIjd2q2XjtioeerErmsyiB7CmHcPIxp0kkQW0uMpcVrA50hEjEAUgrBcXE2UzkA83PS05XqghVLT1fSjb07Q5U1utKvQaFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=EvKFBZKA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dzYY7pX7; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 13FF6138037E;
	Tue, 10 Jun 2025 11:46:15 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 10 Jun 2025 11:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749570375;
	 x=1749656775; bh=sWQd/cEpHYbeMdzEp6MUu3/KzvU4FMthc1pbkqdosho=; b=
	EvKFBZKAplwtJlh5g9Mpb3dq4hCEJt6Jjbk2nMN0PsXZWvZEF+2qXl+JqSkgubR0
	2upi3k0HJpIl4W1HpShG0aejROcTdYn/r5O4ssIf1hRUuHOA669859KNki5a/3u5
	aR9jlTxh9jXqE3su2dFNWSr7LExal/iETVj0D/Q1fRZFXoyPRXwJNluNJa0ViDiF
	nJKWciPx9Sz6ZSkxcUgVSf5NnAKDMWpVEosQhZuel+5wQ+r9cyqlLwK1QqbH4ZrO
	X8ioJJPLM64ww5AnXM2DtcKO+1A19H2FOYl5EqfW+QyR9NrB3hICP78oLhJNS66C
	OkhBhudQ4aiWAfhcD02bwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749570375; x=
	1749656775; bh=sWQd/cEpHYbeMdzEp6MUu3/KzvU4FMthc1pbkqdosho=; b=d
	zYY7pX7gyFK+TkIa1ysxtpLD8g5DEQBxL7z6lGc7BFTU2GL3pJoCR+vRUpJPi5Fj
	GKVbugocUrBc9dFqevN6Zb2ynrsP5/pDw/e+bByHckm7jRlMbdKgXJ6xp5/Iy7wj
	0Lp1c06aaoqQwr7UTf3/tQg+vp5MyqWi6gsfBcRjenjhw1zvPbVODdnONPJZaRVz
	rcAQw1iJVSizU3CmyRZ9zKZMgVFR459vTCu5cN2b5lcunXHo+ALmUlR4T/TXjGxT
	c94rp0adhyp6kB91Zz3gnqNQRv3R7nf2f/PKfW33di20xRB0Je32zc/Q7z+A18FR
	GD43vNqbPRFzy1fYKnBMA==
X-ME-Sender: <xms:RlNIaB-TX9etE2s4t33juPXJPJR3hjUDUKsuRiNzw9aw8LDhw9Amrg>
    <xme:RlNIaFuaaVw0W-TEU-XXCdg7d28u4yHdgAZwh0joF5RWqq7xQCkklLzuzNdvfgeYd
    _5bXSakyAlXdk4ghK4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopeifvghirdhlihhusehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnuhhnohgurghsnhgvvhgvsheslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprh
    gtphhtthhopehrohhmrghnkheslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprhgt
    phhtthhopehsshgvnhhgrghrsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtg
    hpthhtohepuggvtghuihesmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehhrghi
    higrnhhgiiesmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehkhihssehmihgtrh
    hoshhofhhtrdgtohhmpdhrtghpthhtohepmhhhkhhlihhnuhigsehouhhtlhhoohhkrdgt
    ohhm
X-ME-Proxy: <xmx:RlNIaPDS6Gb2fiYaUPdCqmutr2DjEsat7F9y0Pv_HJl69-abk1Jrzw>
    <xmx:RlNIaFfcyNghJBMuS3ggojuxVvv5RwpNSNSLdoQCtTR99VTYMLr9AA>
    <xmx:RlNIaGO_85FF_gvM69SeBk-Oh4HRLoCVo89PfgrBGx23kEntDWs7yg>
    <xmx:RlNIaHkL5uwMkFsoFk1KO7px8fnGOb746MVCpe7uJhSrt4XYYlhm5A>
    <xmx:R1NIaMyIrkATadJCdtrFGFa80cz0M6HDP863PdBs_3UOIqjmAWjLFDDD>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C72ED700061; Tue, 10 Jun 2025 11:46:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tc9e620b0a09597a4
Date: Tue, 10 Jun 2025 17:45:54 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Roman Kisel" <romank@linux.microsoft.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Dexuan Cui" <decui@microsoft.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Michael Kelley" <mhklinux@outlook.com>,
 nunodasneves@linux.microsoft.com,
 "Saurabh Singh Sengar" <ssengar@linux.microsoft.com>,
 "Wei Liu" <wei.liu@kernel.org>
Message-Id: <df1261e1-25d4-43ae-88c4-4f5d75370aee@app.fastmail.com>
In-Reply-To: <20250610153354.2780-1-romank@linux.microsoft.com>
References: <20250610091810.2638058-1-arnd@kernel.org>
 <20250610153354.2780-1-romank@linux.microsoft.com>
Subject: Re: [PATCH] hv: add CONFIG_EFI dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 10, 2025, at 17:33, Roman Kisel wrote:
>> Selecting SYSFB causes a link failure on arm64 kernels with EFI disabled:
>>
>> ld.lld-21: error: undefined symbol: screen_info
>> >>> referenced by sysfb.c
>> >>>               drivers/firmware/sysfb.o:(sysfb_parent_dev) in archive vmlinux.a
>> >>> referenced by sysfb.c
>>
>> The problem is that sysfb works on the global 'screen_info' structure, which
>> is provided by the firmware interface, either the generic EFI code or the
>> x86 BIOS startup.
>>
>> Assuming that HV always boots Linux using UEFI, the dependency also makes
>> logical sense, since otherwise it is impossible to boot a guest.
>>
>
> Hyper-V as of recent can boot off DeviceTree with the direct kernel 
> boot, no UEFI
> is required (examples would be OpenVMM and the OpenHCL paravisor on 
> arm64).

I was aware of hyperv no longer needing ACPI, but devicetree and UEFI
are orthogonal concepts, and I had expected that even the devicetree
based version would still get booted using a tiny UEFI implementation
even if the kernel doesn't need that. Do you know what type of bootloader
is actually used in the examples you mentioned? Does the hypervisor
just start the kernel at the native entry point without a bootloader
in this case?

> Being no expert in Kconfig unfortunately... If another solution is possible to
> find given the timing constraints (link errors can't wait iiuc) that would be
> great :)
>
> Could something like "select EFI if SYSFB" work?

You probably mean the reverse here:

      select SYSFB if EFI && !HYPERV_VTL_MODE

I think that should work, as long as the change from the 96959283a58d
("Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests") patch
is not required in the cases where the guest has no bootloader.

Possibly this would also work

     select SYSFB if X86 && !HYPERV_VTL_MODE

in case only the x86 host requires the sysfb hack, but arm can
rely on PCI device probing instead.

Or perhaps this version

--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -19,6 +19,7 @@ config HYPERV_VTL_MODE
        bool "Enable Linux to boot in VTL context"
        depends on (X86_64 || ARM64) && HYPERV
        depends on SMP
+       depends on !EFI
        default n
        help
          Virtual Secure Mode (VSM) is a set of hypervisor capabilities and

if the VTL mode is never used with a boot loader in the guest.

     Arnd

