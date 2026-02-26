Return-Path: <linux-hyperv+bounces-9009-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCY+EvxLoGnvhwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9009-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 14:34:52 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B178D1A6A41
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 14:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5C063005EB4
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 13:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B402D335BAF;
	Thu, 26 Feb 2026 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFx80W/8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F1D3358B5
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112610; cv=none; b=Jqx3abhpvjuURiZsJXuVJP0Zo5bH4T9CGE0u1FYQBZGUP3VutPlsIxDbz2Uy13+8w46mWDmEyKARBy5IsVKS3HrMxIUTPZL9T15oFff4krHfWTu/lrVPaXH/jvUhT537zTQ48UjXiyYmraJSwyfBTf+E6/MipgsIEjqZylBX2I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112610; c=relaxed/simple;
	bh=r8P4shjRJY4+DE/1qVy4xzfeXySken3P8CWyP8NuTjs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IbCZds8dAxlTsqYAI2BzeFeuXAht8+qEuSmcbsSnAjEhnt9DK3Ry7OoE0u93ND2NAchY6G6y+ICB+UswRbiDImppcV0YfENxjqzEjDOczhJtGcgEnijPNW/m/NsXzzJzx93lJRmX4zlG/5IqajzbFR3DyJ3Fp52KsYW3PSredRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFx80W/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6584C4AF0B;
	Thu, 26 Feb 2026 13:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772112610;
	bh=r8P4shjRJY4+DE/1qVy4xzfeXySken3P8CWyP8NuTjs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=YFx80W/8T/kYfhvNHlSynIgUxTpsHwEx8mkTrmSqVQStf3wkm1T3Ld1ekGJpxsLTN
	 RHiw9BLK6Tx2xNuWii7vtp0sEFm77HKYa7MnZ4TAqGOBqZKttKFrB6Rm1DR47zDHTY
	 PzKUJPvvjemi9tdJJuxH9NgjdVexpPvrMFdKGMf7W0NFJPervkHy0AQwFRwG1rgIPt
	 GDcp0XlRtsGk6POLcCvrZpaqRCh/7b3ExaA3O1pOlb7X+EUadEWIfVlZg6gGpZrrxp
	 4Ym4YpXyM+YgImBVNyBm/xcbvXiDJqNvvqCG9Nl9t5mkSl0IB72PYF2Mq8qRiAnRq3
	 b5Dh1U50jlblg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id C65EBF4006B;
	Thu, 26 Feb 2026 08:30:08 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 26 Feb 2026 08:30:08 -0500
X-ME-Sender: <xms:4EqgaVIqch_7WO5pduVmmkmZFrLvG3TR0LStvgOuUEuNCEUb3IPcWQ>
    <xme:4Eqgab-EyPC4KVEDBX6-6z9Tm0dx8BxMPU9soMhU6d76dg_YLFGQ_MzCcetPkgM_x
    Cy-whqtA1cbDibtV8zykq-ILSy9tiOLwmVs_nXCv8MCAcbrfST0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeiudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeuteeiudeigeekjedvheduieehteetgfdtuefghfejgffhfedtleehvdeh
    fffhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtoheprghnughrvgifrdgtohhoph
    gvrhefsegtihhtrhhigidrtghomhdprhgtphhtthhopehusghiiihjrghksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepthhglhigsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    ifvghirdhlihhusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvgdrhhgrnhhs
    vghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrrghthhhorheslh
    hinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopeguvggtuhhisehmihgt
    rhhoshhofhhtrdgtohhmpdhrtghpthhtohephhgrihihrghnghiisehmihgtrhhoshhofh
    htrdgtohhm
X-ME-Proxy: <xmx:4EqgabC_qoSvsnbYmzGZxEPwd58FlQopPN4-wQbInMdaT1YNX9NlFA>
    <xmx:4EqgaZGNvZEAn9-eefQWApctEriUn-dWbSzd2MGOCnzmDIb3z4DlKw>
    <xmx:4EqgaWOXPLWs-JZ5MDA2B0mGdEy0akWG1jf1FRxToS4q6CHzg7lefQ>
    <xmx:4EqgaajGxreTFPQ7anX3dv8Ew0UKY-W3IaDx7UUAOX4-60LVsyMsqQ>
    <xmx:4EqgaW0NT73fQCzHp3aHcPZIjFCrG8wJCxFbV4ljtfwNigZsb3Sm288E>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A2EC4700065; Thu, 26 Feb 2026 08:30:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZdU3QzfaZ07
Date: Thu, 26 Feb 2026 14:29:48 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Andrew Cooper" <andrew.cooper3@citrix.com>
Cc: "Borislav Petkov" <bp@alien8.de>, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com,
 "H . Peter Anvin" <hpa@zytor.com>, kys@microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Long Li" <longli@microsoft.com>, "Ingo Molnar" <mingo@redhat.com>,
 "Mukesh Rathor" <mrathor@linux.microsoft.com>,
 "Thomas Gleixner" <tglx@kernel.org>, "Uros Bizjak" <ubizjak@gmail.com>,
 wei.liu@kernel.org
Message-Id: <2ee05c7f-60cb-445b-b761-562385c4e6ba@app.fastmail.com>
In-Reply-To: <ccc4f915-3623-406e-8df6-f468427264f4@citrix.com>
References: <20260226095056.46410-2-ardb+git@google.com>
 <5a2f3ffd-1692-4c32-b6f7-b94e5066dd95@citrix.com>
 <a7e1b5c1-f933-44e5-99ec-a83b27fcf81e@app.fastmail.com>
 <ccc4f915-3623-406e-8df6-f468427264f4@citrix.com>
Subject: Re: [RFT PATCH] x86/hyperv: Use __naked attribute to fix stackless C function
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-9009-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[alien8.de,linux.intel.com,microsoft.com,zytor.com,vger.kernel.org,redhat.com,linux.microsoft.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hv_crash_ctxt.ss:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B178D1A6A41
X-Rspamd-Action: no action



On Thu, 26 Feb 2026, at 14:24, Andrew Cooper wrote:
> On 26/02/2026 1:07 pm, Ard Biesheuvel wrote:
>>
>> On Thu, 26 Feb 2026, at 13:01, Andrew Cooper wrote:
>>>> @@ -133,49 +150,36 @@ static noinline void hv_crash_clear_kernpt(vo=
id)   * available. We restore kernel GDT, and rest of the context, and c=
ontinue
>>>>   * to kexec.
>>>>   */
>>>> -static asmlinkage void __noreturn hv_crash_c_entry(void) +static v=
oid
>>>> __naked hv_crash_c_entry(void)  {
>>>> - struct hv_crash_ctxt *ctxt =3D &hv_crash_ctxt; -  	/* first thing=
, restore kernel gdt */
>>>> - native_load_gdt(&ctxt->gdtr); + asm volatile("lgdt %0" : : "m"
>>>> (hv_crash_ctxt.gdtr)); =20
>>>> - asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss)); - asm
>>>> volatile("movq %0, %%rsp" : : "m"(ctxt->rsp)); + asm volatile("movw
>>>> %%ax, %%ss" : : "a"(hv_crash_ctxt.ss)); + asm volatile("movq %0,
>>>> %%rsp" : : "m"(hv_crash_ctxt.rsp));
>>> I know this is pre-existing, but the asm here is poor.
>>>
>>> All segment registers loads can have a memory operand, rather than
>>> forcing through %eax, which in turn reduces the setup logic the comp=
iler
>>> needs to emit.
>>>
>>> Something like this:
>>>
>>> =C2=A0 =C2=A0 "movl %0, %%ss" : : "m"(hv_crash_ctxt.ss)
>>>
>>> ought to do.
>>>
>> 'movw' seems to work, yes.
>
> movw works, but is sub-optimal.
>

Can you give an asm example where movl with a segment register is accept=
ed by the assembler? I only managed that with movw, hence my comment.

