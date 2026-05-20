Return-Path: <linux-hyperv+bounces-11054-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ednILXi8DWrH2wUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11054-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 15:51:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C5858F168
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 15:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93E4130055F3
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 13:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5495325491;
	Wed, 20 May 2026 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kvj+2jXX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YPjGPDmp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BD41C3BEB;
	Wed, 20 May 2026 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285107; cv=none; b=IIquWz/knAgROrSkcmSNMJA9J7X7jKN8sN1iiXJDXfTPyFjv6y8+PTG/YVN8ywpJMmuat6VrIrwT0l4/FCkgM2O67SPBkT6bBds1nSNRZAAJ095goasY80LBK7d4fdXi6g8kPvJv3O7NsazjudR+vLm9vcOE2VEC6rMRgqlMMAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285107; c=relaxed/simple;
	bh=+l+rx39+rKB4+UNQuCrcQV9RbLE0SI/GMrObBvMVk7c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CfwLHDv4+gqkkIclKHxqZbr0HoeBn8s0cDpzatXv9azSpu+KlYEz93LFlmfTBCeAdEZw6WVeScX9DjhFT0U7rxP5/ddyFRqRv37r/w6Fw3ITm1OZmvy2RsOthgnINSVUCqCT+Y4zpY0a5SwTzyXgi5gBth9hKCtdoEPrqodeFG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kvj+2jXX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YPjGPDmp; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D0C5C1D000DA;
	Wed, 20 May 2026 09:51:44 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 20 May 2026 09:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779285104;
	 x=1779371504; bh=qnGusLRDJf3sqYJCqMeYHPVott5di2jJhd0PFff8o5c=; b=
	kvj+2jXX0AA4oMzK3iwBg1gnfJ36YUPQTyV0zWicTjTkytBUtxCVOO79dDt4hWsJ
	EBR8fSRagRCl4OrpvnhA3jura2KsQUjxEYekeOHzzqV/N+hziN9+AWBmGKuBn882
	b+e3E4dbFNymZYYgdB5eF21cCpRl3T5RWHL/nY5+AUPLqJfSd1S0J0Amf0EDGeJc
	ayXZyur4azpoHmYjC5pqd1c9+m2KwdtSscfE/96h1phE2w0gJ1vmG0cvev4nnVHG
	qS2O4pnj2LNCW0ntkuNxl1kWs60VtRKKcLXHzlGjdqFwf9Ju+NTOxmWAlgOY2Tfp
	PQHZCVUWQspXInI8PuuxVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779285104; x=
	1779371504; bh=qnGusLRDJf3sqYJCqMeYHPVott5di2jJhd0PFff8o5c=; b=Y
	PjGPDmpXNo9NSkvxZAIiVDMQnKPVR8JytPJfanwUSxWQVEO7bO/8OHjg8jCF1WhA
	qHnsBkN22zzS6jTTUCgIDkfhjE39I8AjO02DiF8ZWig+vtxTuTAxzRTP4u2WUCOB
	hpscdJ04hz8Wn2dhvtNNndd/o0/VcRCJJX62aLAo3syPdzES7o4YcQOjbKrjErSl
	ZXk4sroTns8RiuAAIwYO2WcFKyd2qTXijsCtDT34F66UjGGwj54xFEmU4wHrIhH4
	UoM3sEHSXW3aA/S2ZzYgX2g8AK53Drmyb/0NLgkGnqFhzOCq+0UAnLPPaZ4WrGdU
	gBvgQLAZ1yw/ikUuRvLsQ==
X-ME-Sender: <xms:cLwNai-Nik8AniIJ-yx98d1vJvQE7eWHhGJfgs-ZiDSgku6qjM7PAA>
    <xme:cLwNatgquR2fzayWDAyJIEDiJS6V8IuEAmH9aYqKg034J6hxOOmSNFAFnFiUwKCmS
    M63BZTDkCfE1y4_ERyS2AjOqcHh-ALmcHpNDI6GnHGyThEsuxRlX_U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeegkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegrnhhirhhuughhsegrnhhirhhuughhrhgsrdgtohhmpdhrtghpth
    htoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopeifvghirdhlihhusehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhovghsvghrsehlihhnuhigrdhmihgtrh
    hoshhofhhtrdgtohhmpdhrtghpthhtohepshhkihhnshgsuhhrshhkihhisehlihhnuhig
    rdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepuggvtghuihesmhhitghrohhsoh
    hfthdrtghomhdprhgtphhtthhopehhrghihigrnhhgiiesmhhitghrohhsohhfthdrtgho
    mhdprhgtphhtthhopehkhihssehmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtoheplh
    honhhglhhisehmihgtrhhoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:cLwNatu9tMv2k8R7Co-5d8He4BGnsI7Av_dhiZNX9_qQ15yaUi6vBw>
    <xmx:cLwNas832XPf3rcKPyl59FRHzQD420oHJS8Zr5AxaNkreAUEcCbxrg>
    <xmx:cLwNauzHXgnC6sov-qGR874MgE11zWrk9lic-v35My_2FsJOR3qr3Q>
    <xmx:cLwNam9zMyj0O1ObElS_TT7rncv1csqJc9f03xf8WEgWa_JRMj54ZQ>
    <xmx:cLwNar28LttyD5yYwD6LFyUaL0KkAa0gETYplIChfXVNjeB3gjvMq3RH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 43726182007A; Wed, 20 May 2026 09:51:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-QabHOIBTMg
Date: Wed, 20 May 2026 15:51:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael Kelley" <mhklinux@outlook.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>,
 "Dexuan Cui" <decui@microsoft.com>, "Long Li" <longli@microsoft.com>,
 "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>,
 "Jork Loeser" <jloeser@linux.microsoft.com>,
 "Stanislav Kinsburskii" <skinsburskii@linux.microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <56938994-3795-415a-8be3-16e28236082b@app.fastmail.com>
In-Reply-To: 
 <SN6PR02MB4157CDF10D33D62DD8709D63D4012@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260520074044.923728-1-arnd@kernel.org>
 <SN6PR02MB4157CDF10D33D62DD8709D63D4012@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: Re: [PATCH] mshv: add vmbus dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11054-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[outlook.com,kernel.org,microsoft.com,anirudhrb.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,arndb.de:dkim,app.fastmail.com:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: E1C5858F168
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026, at 15:46, Michael Kelley wrote:
> From: Arnd Bergmann <arnd@kernel.org> Sent: Wednesday, May 20, 2026 12:40 AM
>> 
>> When the vmbus driver is not part of the kernel, the mvhv_root
>> driver now fails to link:
>> 
>> ERROR: modpost: "hv_vmbus_exists" [drivers/hv/mshv_root.ko] undefined!
>> 
>> Avoid this by adding an explicit Kconfig dependency. Note that
>> stubbing out the hv_vmbus_exists() based on configuration would
>> also work for some cases, but not with MSHV_ROOT=y and HYPERV_VMBUS=m.
>
> Conceptually, the MSHV root code should not have a dependency on
> VMBus. The "does VMBus exist?" question should handled differently
> by setting up a boolean in the core Hyper-V code that defaults to "false".
> If the VMBus driver loads, it would set the boolean to "true". MSHV
> root code would query the boolean.

That makes sense to me, but it's outside of my area for a drive-by
build fix. Please treat my patch as a 'Reported-by' then, I expect
this can easily be addressed by Jork or someone else in the
hyperv team.

      Arnd

