Return-Path: <linux-hyperv+bounces-8481-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNdCEKoJc2mWrwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8481-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 06:39:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7F3707D4
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 06:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EEBE300E710
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 05:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D6339CECE;
	Fri, 23 Jan 2026 05:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="p6FF3561"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF373904DC
	for <linux-hyperv@vger.kernel.org>; Fri, 23 Jan 2026 05:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769146784; cv=none; b=MSE7iXhZnRp4PnA7k/HyUAhUuiUZCectg4nc8GcVbRF4i8GnCsXg0PYNcaKt7YjYSQOh0rmMbzopGi+Q7bWGhOiV9+Tva5icQK7JZzwir5haaXYokRFjKpbTDfOkd85O2QfUacreXgjSUTJXFU8+8I8rO+zLbBhK8K4SuhlPpcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769146784; c=relaxed/simple;
	bh=I8rYsPArjClMI0OlY9LdFMlzeRq2tpFxbh33gFcF2Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9CaR5K6HDqoAZcNYIkLunm6yoH1P4gcRbnHfVm26Mc8Ond00siM+87HN7pEOc2+M+cD1WT/I5QwH4aey1I1J159/iGyoxzVN9vZk4uR9DfR0YbIDkqm3X64iu4FUVgW70YplYefAb9erm2lHGlmIkvCujK8qH9HXm3/fbE8QBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=p6FF3561; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A5CB83FB5C
	for <linux-hyperv@vger.kernel.org>; Fri, 23 Jan 2026 05:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1769146767;
	bh=zLCXslpHHlmT4bEIPeZoanKUUqxnGQJncWC/wm2gT8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=p6FF3561yXGfz5fqeqQz2r4udX3FHAQUJXjNi7jt9JjUqkTwwT1KfEwklwzMs36Wx
	 LqrAR0m01vr7iwk7fgS9JednvyYJ+kbwS1arr49in5duzpBb5AnHnmuCJ1d/YeWM3l
	 cJ4Tuzj7vBy82hfSmdzE2xMk2k2tNvXHh0OWooul/qyGVZsgcvw3ZL0sYEI8+HAeL4
	 vmJw+MSbRTYfmT4rWq+mk6ZHw6OpmS10/uW0LhGBcMClkjlhpAhnzcdNP4MNLPUU2B
	 C20zXIuunk8sTD/7cOI5i0NRYhVP7M/q0LP6qGfbW++6YSiBb3thlo+eTW6eWxUp/v
	 f6Rueb74GcszESsYmqPPtVRPCVG8cJyPuez+NC+NNe0DxZvAxiNhP/+LNxIHZb1L87
	 dUX8/8QY4ItBbDFN383HP0o1JIqAtxyGHYSkTJmN5cP7iPiweXxEZv9mJoaLUoIumv
	 jmKxH3bSFprk9+vrDjsp3cHv2hZdAv+AakLSGI3ibfpz0BYe3NHkBl08x7NQUmFMlG
	 lgxIyAeLPycjdmOM9Dg2GQ/7bA2G22pBgsqhpyhPJ4aiRzn0sxyo8Mqe6Pq+EDdA/p
	 jw/Q5YzY7yglKmRWXAD7xd2aDkrdnBY0RHei8qgvdjmyNhEaeWUe6uf/B2OvKqHplI
	 p5KLi3k9zaFwMaZbOgMiDWhw=
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34ea5074935so1634278a91.0
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Jan 2026 21:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769146766; x=1769751566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zLCXslpHHlmT4bEIPeZoanKUUqxnGQJncWC/wm2gT8A=;
        b=B4jRP4MTCZE1hOJeyiGbAjWeWt4gXA5eZ6ZxAy4pTcCf1tBmoMsxwjjJe+u41OR30o
         Pt1DH4520kviLHaGC0lD9v+J4svmhn+EF4sCWelYI355Wl91BgweT8S7zisUhvcQmbW1
         ynKA2sjRrlgsVp3dpLyUBFd6Z46X8HK47C6IkDEvWMrwlhUzrAvJpTUHD38g1u3P6ncy
         IQrndYr8dUw15p67rTcbf+xxbC6Hd/SsYEQP33qfrvHlcDMhNhZEZcOwZbQXh18eGESg
         kf8SDfncKZwNTKsUuFnPPbzJZOkwcX5GYDZYSOiiGDt8HkwnCtsdoyOiBx3LUhOB3bVw
         9N5w==
X-Forwarded-Encrypted: i=1; AJvYcCUuZj9n7w+LVFICi/HPZ9OhPxVoLvUgrx1c55nP5QoORTlFk4ToU3bMJZQiKh+ZzD202fM/HbudYhdTGdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOgK2ZfmvBiTSO4oSypKhNPvXPi0D32XQeGcW8b69GsJJL6q1+
	zDXQZGBA1t/4VNQhEdiyckHVO2CHR2o8/E1DLkQ34VGNBNBfx5msdmFpz1XVTGVMgZHeHFG/XV1
	rgIkZlgwTibFRlR5fszijBTbw1tzXqoaCzC+2IxfAo7zTVdN3TP7YTI2Jx9do0mN/maourN5Tfj
	Rc6ib0Fw==
X-Gm-Gg: AZuq6aJbhizjimJPZ4fnJzKvYMQYdwK3KlzRQriy9KCLwbYQWza1X2Vddy6xVP/XsPZ
	6oL/9SPV0JfjFGJ9xvYz5BNfxoyia29FEaEwz817tFs3l0MMG4+bB0jzwA1tmqBI0QGT/4oazMl
	c10CqwGAH4CSJ9Wg+DJ0x6D3uicVOwGIFCLyMoviMojW0o1lLGADGsHn3b6igJ0m+nQxK+1IVXA
	p4WmudDbhmOOVsAL3acU4Pnq8PsPYYexp4UZxzXtQpEi5xh19n+8vaw297HdPPL/iWAMq+CegTU
	B3TZ/FjjGHIdzX/hNJbuGEXoGRNYTGsA6WcqVuovCvcC5rCRUn/s+ZSvH/H4b9KgXoxT+y5QX/g
	VpuscCMt0AtcYog/1B4ekTJ/JxTG8WD3betXCXSDsmXSPjEX/V4A=
X-Received: by 2002:a17:90b:5625:b0:352:bdcd:118a with SMTP id 98e67ed59e1d1-3536894d548mr1542090a91.21.1769146766172;
        Thu, 22 Jan 2026 21:39:26 -0800 (PST)
X-Received: by 2002:a17:90b:5625:b0:352:bdcd:118a with SMTP id 98e67ed59e1d1-3536894d548mr1542072a91.21.1769146765830;
        Thu, 22 Jan 2026 21:39:25 -0800 (PST)
Received: from Garunix (122-58-172-36-adsl.sparkbb.co.nz. [122.58.172.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536f25c4c5sm417930a91.6.2026.01.22.21.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 21:39:25 -0800 (PST)
From: Matthew Ruffell <matthew.ruffell@canonical.com>
To: mhklinux@outlook.com
Cc: DECUI@microsoft.com,
	bhelgaas@google.com,
	haiyangz@microsoft.com,
	jakeo@microsoft.com,
	kwilczynski@kernel.org,
	kys@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	longli@microsoft.com,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	stable@vger.kernel.org,
	wei.liu@kernel.org
Subject: RE: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config window
Date: Fri, 23 Jan 2026 18:39:09 +1300
Message-ID: <20260123053909.95584-1-matthew.ruffell@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SN6PR02MB4157545DAFDCCE0028439DB2D497A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <SN6PR02MB4157545DAFDCCE0028439DB2D497A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8481-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.ruffell@canonical.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[canonical.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DB7F3707D4
X-Rspamd-Action: no action

Hi Michael,

> > I wonder if commit a41e0ab394e4 broke the initialization of screen_info in the
> > kdump kernel. Or perhaps there is now a rev-lock between the kernel with this
> > commit and a new version of the user space kexec command.

a41e0ab394e4 isn't a mainline commit. Can you please mention the commit subject
so I can have a read.

> > There's a parameter to the kexec() command that governs whether it uses the
> > kexec_file_load() system call or the kexec_load() system call.
> > I wonder if that parameter makes a difference in the problem described for this
> > patch.

Yes, it does indeed make a difference. I have been debugging this the past few
days, and my colleague Melissa noticed that the problem reproduces when secure
boot is disabled, but it does not reproduce when secure boot is enabled. 
Additionally, it reproduces on jammy, but not noble. It turns out that 
kexec-tools on jammy defaults to kexec_load() when secure boot is disabled,
and when enabled, it instead uses kexec_file_load(). On noble, it defaults to
first trying kexec_file_load() before falling back to kexec_load(), so the
issue does not reproduce.

> > >  	/*
> > >  	 * Set up a region of MMIO space to use for accessing configuration
> > > -	 * space.
> > > +	 * space. Use the high MMIO range to not conflict with the hyperv_drm
> > > +	 * driver (which normally gets MMIO from the low MMIO range) in the
> > > +	 * kdump kernel of a Gen2 VM, which fails to reserve the framebuffer
> > > +	 * MMIO range in vmbus_reserve_fb() due to screen_info.lfb_base being
> > > +	 * zero in the kdump kernel.
> > >  	 */
> > > -	ret = vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, 0, -1,
> > > +	ret = vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, SZ_4G, -1,
> > >  				  PCI_CONFIG_MMIO_LENGTH, 0x1000, false);
> > >  	if (ret)
> > >  		return ret;
> > > --

Thank you for the patch Dexuan.

This patch fixes the problem on Ubuntu 5.15, and 6.8 based kernels
booting V6 instance types on Azure with Gen 2 images.

Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>

Thanks,
Matthew

