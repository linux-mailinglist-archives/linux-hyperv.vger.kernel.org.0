Return-Path: <linux-hyperv+bounces-9046-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPgXAOgXomnFzAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9046-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 23:17:12 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6211BE9C4
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 23:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E67131BFFE4
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 22:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6535A47AF46;
	Fri, 27 Feb 2026 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YS6i0NkH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F65E47AF4B;
	Fri, 27 Feb 2026 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772230273; cv=none; b=Yp7CE2FYlVEJ6UPkyBPwv0526MXOQN0N3n4xzEaUYA9p9TkniISboR4JxlUpwwYCOYhP1pSCclYpnxiZLYahfrqqp0ILNsva1ltExn+xVIfcjyc6BQn3BN5gnuoJM6Lym/fezYbBhyXNcvr1qyWiZC6DDv5KgzcLrESOC2w7FYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772230273; c=relaxed/simple;
	bh=xBkQMPHPSs/zMDHS8KArKPdBlnLGvJX0MzKYRKJH4JE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cGqGS9Gk8yufh3Sva6RBBvaUflzyZ14HDpuqpfLsDninZj8GgWHsTCbSBXXEcBeXMPKbtdslE0iHhCN53dwHdrers1N4i8cfwAtMTubfk7iKiD0LIdRPLJm9cg/dQ+EygCscwtLeooClfvgPFKrtE7a9DRmJySuqduKaGGWCR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YS6i0NkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FC7C4AF0B;
	Fri, 27 Feb 2026 22:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772230272;
	bh=xBkQMPHPSs/zMDHS8KArKPdBlnLGvJX0MzKYRKJH4JE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=YS6i0NkHhU3rmbAGdEl7XkIdlOzzFqfAt2iuGpNE9oLz9A2vqg6m9QF20JQA3YVFU
	 iZ/WutRQVJKFB34ziHeyUZJA61S53iP3GmDY27ppwtvW5bqU5Vl0Q4F0CxZONKJVmm
	 LhPqCR5+LOZiftbvIXgkZ4KImwRs7JM0+bDApf4mXr8arYYSOflbKkVMr4HnrlBgGd
	 1U21M7gz0magpM7vBeb7YQhLdig+JSu1Eg7xuGaZcbrkeNGGbvTO8m0wXyWN7xHzKk
	 ByvNNA5DyIuuxHZ6/yvPrGfAHy5hl7FXWn8nwKSqmSNygm+8uYL8+FskPgLagGULzR
	 7RisLylfhmf1w==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 313BEF40068;
	Fri, 27 Feb 2026 17:11:11 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 27 Feb 2026 17:11:11 -0500
X-ME-Sender: <xms:fxaiaSN8uccu8dDqA0AUgLxRpsrGobv_Qv9pMfKfsQ9gaXJx_p_APg>
    <xme:fxaiabwgVFW9UU61h81Q5fXzHdubvm0TZ4W6hzcv-ZSOjL-FOEPYEjDFAZzQVncHj
    BZfnXxHa4HO0ymX2Yj52x-EPhs2cEeXwVT_hWBqAnjrPw7I0iCh6yU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedtudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtoheprghrnhgusegrrhhnuggsrd
    guvgdprhgtphhtthhopeifvghirdhlihhusehkvghrnhgvlhdrohhrghdprhgtphhtthho
    peigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhroh
    hnihigrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhht
    vghlrdgtohhmpdhrtghpthhtohepmhhrrghthhhorheslhhinhhugidrmhhitghrohhsoh
    hfthdrtghomhdprhgtphhtthhopeguvggtuhhisehmihgtrhhoshhofhhtrdgtohhmpdhr
    tghpthhtohephhgrihihrghnghiisehmihgtrhhoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:fxaiaSxMu2ZGgzPSuLKnBUXBkhJtK_u-0KWeCeJEoIU3zMBYVml3Og>
    <xmx:fxaiaT1Wchjzcwq8n8PocsyGqvQSoVwcf_NWNUQODIyIxXvGSz9Mnw>
    <xmx:fxaiad4Nt5yZSwnWrrOMV4voRvU2Cl_te4jvr10TzfotVdNnskwrgA>
    <xmx:fxaiaZaZlFyTr8u-DSiO4ZGR3eCBgZfl-EHTKU1z_kshFeWLmlTx-Q>
    <xmx:fxaiabREhg14ER5TqoRSspkOuymxccAn2lVXUXpXDeQ1iO27_A8VFcuV>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0EE39700065; Fri, 27 Feb 2026 17:11:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABHypM1vLXn-
Date: Fri, 27 Feb 2026 23:10:25 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Wei Liu" <wei.liu@kernel.org>,
 "Mukesh Rathor" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 dave.hansen@linux.intel.com, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, "Arnd Bergmann" <arnd@arndb.de>
Message-Id: <6fa1df5a-b4cf-4f70-9d46-7d82bedfb01c@app.fastmail.com>
In-Reply-To: <20260227213733.GA976651@liuwe-devbox-debian-v2.local>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-6-mrathor@linux.microsoft.com>
 <38cdec03-889e-43dd-9dad-e621aba9dc8d@app.fastmail.com>
 <f8199494-0c42-5eb0-f99e-cc6f6e304d40@linux.microsoft.com>
 <eb1c44d7-2664-4269-8824-e90e5a8494b2@app.fastmail.com>
 <6a601546-a26f-79f6-a3b0-be145dfa7781@linux.microsoft.com>
 <20260227213733.GA976651@liuwe-devbox-debian-v2.local>
Subject: Re: [PATCH v1 5/6] x86/hyperv: Implement hypervisor ram collection into vmcore
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9046-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5D6211BE9C4
X-Rspamd-Action: no action



On Fri, 27 Feb 2026, at 22:37, Wei Liu wrote:
> On Fri, Feb 27, 2026 at 12:05:13PM -0800, Mukesh R wrote:
> [...]
>> > 
>> > So? But does it means to 'be in asmlinkage' in your interpretation? Did you check what 'asmlinkage' actually evaluates to?
>> > 
>> > I am not asking you to justify why this broken code works in practice, I am asking you to fix it.
>> 
>> 
>> STOP bossing me! I am not your servant nor your slave. And you are not the
>> only genius around here.
>> 
>> Now, many people looked at this code before it was merged and no one really
>> thought any self respecting compiler in modern times would create an issue
>> here. Still, I see the remote possibility of that happening. All you had
>> to do was to show your concern and suggest using __naked here (which looks
>> like we all missed, or maybe it came after the code was written), and it
>> would have been addressed. This is x64 specific code for very special case
>> of hyperv or kernel-on-hyperv crashing.
>> 
>> In future if you choose to correspond, watch your tone!
>
> Mukesh, there is no need to be so emotional and defensive.
>
> I don't think anyone, no matter how good he or she is, knows all the
> intricacies in the kernel. We're lucky to have other people look at our
> code and point out potential issues. Regardless of your opinion on the
> discussion, we should be thankful for the time and effort people put
> into even sending an email, let alone a patch.
>
> Let's keep the discussion civil and constructive, and focus on the
> technical aspects of the code.
>
> Ard, I want to let you know that I appreciate you raising this issue
> with us.
>

Much appreciated. And apologies to Mukesh for my harsh tone - I should have been more diplomatic in my response.


