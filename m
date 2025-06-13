Return-Path: <linux-hyperv+bounces-5907-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51014AD9290
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 18:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BF31884387
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 16:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554B120E030;
	Fri, 13 Jun 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="n8vJJkcX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JfZsfLrc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A32E11D2;
	Fri, 13 Jun 2025 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830856; cv=none; b=jPJlx7r3ppF76IGLLmr+CcWDPd/RH/kH/UDUdTHDRbpP4hD8dkqZmeuy4RQLSwlMB9sAdpnLRw1uhHj7T3+6CjK0SKwRTsx5CP4SbrYHDqkqEiPzvbX+K1Puo5Mk4cVStFKpVU0jJxeN8xLG4+Tx01nzvDRsdJH4V6zGLijlI7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830856; c=relaxed/simple;
	bh=MNz8gwHFXSriklMe/8KoYKMqq4hYPlrQVKa1bvbLYLk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sb0ZivXZ31GGwvATUqe9W6lbB8SpHpiTgT2O+aBc0obrMzSrMojwPnugd0y/sOzh35zo8+5waCq4v8xbJK5bAlWMR2vtGbhtQ0Fr3SqVGH0ogBvVfekhSYs93WJV6ffIFsK843o8jeS7MJpRUd1SSI5zd/l7gJAWsiIgb2JzH3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=n8vJJkcX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JfZsfLrc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 89A5B1380394;
	Fri, 13 Jun 2025 12:07:32 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 13 Jun 2025 12:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749830852;
	 x=1749917252; bh=V20vyYK7C1e227OIfs4VLw6bkef6iatlvuFGlABdYfg=; b=
	n8vJJkcXcxEe3xviJVzSsGYutA63lu2pc/ll6HtDgvk0zU9wS4jznBbIEyrrJBlh
	64eeHIrhUxlEf6BmPgH1xR2iaAisTOvp7exZSgxo4I5PvPLqPOm3sDPjR0X4Gmlt
	lMKAa3F7/GSJkyxMVDITMlGJQuOymNUheSO6tCnUkgtU7HiVVOjtSLv+yirUfnWl
	e6KEUcto/rB3TJZKSCxjG9NiRk2rzZ/UqcYkcCRN3afOy8F0cKSLEoqnZd8qivUU
	OVSdWYSUFAr/QppvaPus96Ay+nfYuZh1sS7b6DMiDhXRXCetBFyWxjd5y9+vmVnK
	Rkx6TXd2rutkk5ujt4JdnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749830852; x=
	1749917252; bh=V20vyYK7C1e227OIfs4VLw6bkef6iatlvuFGlABdYfg=; b=J
	fZsfLrc9CVCpIUpxcWUKPRrK+BhAzGqUnC3+7m58WzGAl590mvj50nnXp5QD6/8W
	zlmL0kMpsny8oc9RCM1vEFH5UHek9tX4JwIx+X4AwLPmUXYrTkKp0g+iSWPRlaFK
	Rlji7cFCcMy7DKWRazjyuBpdiFKGpZJf33ZXfgsRPWzuwF5Nxl8yOs37R9FvDkzj
	heLoimlSUXPSdsNcKsM2iUCoBWJiRWf3Jzu794HN0JFDHu67islyveQAE4U7IaxU
	UxJex7bwkFL8I08mMIRU1y07wePtjwRZYXKfMmuZ3Z5QzEurmNljnHxWnEGt+kfA
	aD0egE44Q/bWeQaD73FmQ==
X-ME-Sender: <xms:xExMaKmL0Pz8M-QTbuPYe5k6f4xl_QmCLCW8n0nFajUhucrBNtwCqQ>
    <xme:xExMaB1pB5j4hJaeXVMBhWXmWbOpA4mi9ONsNasS7kTi0AtzbxJtE-YVxTcnEOoxF
    5_DkqZETCJXb_GsfUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeefkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:xExMaIontGdfZJ2E60J50iATydKwvQBRScjxGXA7SOZmpshLpHdl9w>
    <xmx:xExMaOk9VmcqGGTBs7fJRTHHpq3AJuQ5rPlKIK8hywqJQnzYrNhimA>
    <xmx:xExMaI12Z9jhrcy8S9DQ421FYlNdDuifusbFFB2tJaT1LA1r7LUcTQ>
    <xmx:xExMaFvEcinH4Tf9WnEt22AnMGBsKpPCu0e9U-DDsTma7UuUHKwjsA>
    <xmx:xExMaJ8DL5TUJkEI1xZeVfnvSPmeI1qRK743zOvUAItWrsComRXf7zvT>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2A520700065; Fri, 13 Jun 2025 12:07:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tc9e620b0a09597a4
Date: Fri, 13 Jun 2025 18:06:53 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael Kelley" <mhklinux@outlook.com>,
 "Roman Kisel" <romank@linux.microsoft.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Dexuan Cui" <decui@microsoft.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
 "Saurabh Singh Sengar" <ssengar@linux.microsoft.com>,
 "Wei Liu" <wei.liu@kernel.org>
Message-Id: <c449d792-fcdc-4b08-a76e-519c0a64525d@app.fastmail.com>
In-Reply-To: 
 <SN6PR02MB4157D600219C00D33D00C3B4D477A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250610091810.2638058-1-arnd@kernel.org>
 <20250610153354.2780-1-romank@linux.microsoft.com>
 <df1261e1-25d4-43ae-88c4-4f5d75370aee@app.fastmail.com>
 <SN6PR02MB4157CE643DEB6CE4B0AEFC00D46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157D3A61C5DB1357267D712D46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157D600219C00D33D00C3B4D477A@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: Re: [PATCH] hv: add CONFIG_EFI dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jun 13, 2025, at 17:50, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com> Sent: Tuesday, June 10, 
>
> There are other ways to express the HYPERV dependency on EFI that is
> conditional. But if the condition includes HYPERV_VTL_MODE (which
> it needs to), then there's a dependency loop because
> HYPERV_VTL_MODE depends on HYPERV. So that doesn't work
> either.
>
> To solve the immediate problem, we'll just have to do
>
>     select SYSFB if EFI && !HYPERV_VTL_MODE

Right. Technically, you could do

    select HYPERV_VTL_MODE if !EFI

but that makes no sense from a usability point of view.

> Separately, if we want to express the broader dependency of
> HYPERV on EFI (at least for ARM64), then the dependency of
> HYPERV_VTL_MODE on HYPERV will need to go away. Three
> months back I had suggested not creating that dependency [1],
> but the eventual decision was to add it. [2, and follow discussion]
> We would need to revisit that discussion.
>
> Arnd -- if you'd prefer that I submit the patch, let me know.
> I created the original problem and can clean up the mess. :-)

Yes, please do, I trust you will come up with a better patch
description than I would.

      Arnd

