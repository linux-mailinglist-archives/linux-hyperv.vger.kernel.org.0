Return-Path: <linux-hyperv+bounces-709-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0717E2C94
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Nov 2023 20:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A39280F00
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Nov 2023 19:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B469628E26;
	Mon,  6 Nov 2023 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDf40gvE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC2128E17
	for <linux-hyperv@vger.kernel.org>; Mon,  6 Nov 2023 19:03:13 +0000 (UTC)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAE3D8
	for <linux-hyperv@vger.kernel.org>; Mon,  6 Nov 2023 11:03:11 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-5849fc56c62so2892053eaf.3
        for <linux-hyperv@vger.kernel.org>; Mon, 06 Nov 2023 11:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699297391; x=1699902191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWUAt9szfs1KF4AGkcAD2A8AgTAn63pRzhXfFkTXelE=;
        b=PDf40gvERrOgfwDkTd4VwvyB1pKS/hh4A+RO6qC5AZMe0Urhmzf4J3XcoLrN1L5UT7
         sy0UEiFI/B0sfsJqATvlcAPgRsJj2RgHFonqFJbiXrrSxaX/ILeAwewPZ3hAWwgOuH53
         LkYLkn0PH1a/984xlwyHg5JFoT7f2LmCjYSni+4WOaBxR64df+2ixpHe1Hcdf2dDlsaJ
         OHCyc/ABSABJS5ZQNZ9VwsWU4uhIKl8UEWgWlKR3OeTFTXnnaDA5FEfsmLSn5HrHxa5Y
         sDU8GvFFMhxNZgGl9f/v+8I62rMheGfNA/ONIghrgPR4YGZvUWCZVRVHmV2dWq0Ri6eA
         jHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699297391; x=1699902191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWUAt9szfs1KF4AGkcAD2A8AgTAn63pRzhXfFkTXelE=;
        b=KpcSThlfCoACfvGGLnTjZIcGvsbwaPv3U5C3JEzzgkamGwg8CSy5qF3ctRMReqGFSn
         bDc3WWL63mFvwQvCd+ed+wUotEk3LQOJzv6r+omWixmZfv5wX92bH03JFQQwGPw2fIb2
         4AMs3l0MvPX3tQGmTArI0MwzGhKiTe2YGiNaP6ZtCNTAv2X3/4ejMpJARZxkhKklCl3c
         u7M1jbhrmBm02i8iYnC8jihCvKiQ8AhZ96etAp8ZCjuk9QAZe7kj6+4BAvBl5VmJm2nN
         N9rswzzcUm1kEtzIjNUkyUua6tx/3iQ2R4xxKpei3GSeNdRs6/LuzQ2dkVJhOUOLNB5j
         MbwA==
X-Gm-Message-State: AOJu0Yw/1tQanJVavoOzBHvV0Ggn3xz0B/0qgGBvugEQzk9eC9kiphf2
	ueE2lnMKznJeyF2cUyfKX5U=
X-Google-Smtp-Source: AGHT+IHu+ArIDyrP7UOJMs+IX6B6QH6XksZbNkcAjGxrCsqtNvpNK3YmD8tkQMWQM6W1l1C2vVt2Ug==
X-Received: by 2002:a05:6358:c3a1:b0:168:f48f:4414 with SMTP id fl33-20020a056358c3a100b00168f48f4414mr28377157rwb.25.1699297391117;
        Mon, 06 Nov 2023 11:03:11 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x3-20020a0ce783000000b0065afcf19e23sm3637602qvn.62.2023.11.06.11.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 11:03:10 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 4EF3127C005B;
	Mon,  6 Nov 2023 14:03:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 06 Nov 2023 14:03:10 -0500
X-ME-Sender: <xms:bThJZa2WpJ0T790GDsKe58palsUc8ol-KRWVkdP8B4Y4s8_NpCH-gg>
    <xme:bThJZdGx5TO7_MpNyftF-VW7WvChCSlTKL3Ks2fvZ-OdNjV8nG97DrK8JLgadBbPT
    Mozjw2UyBNgYbJ29Q>
X-ME-Received: <xmr:bThJZS7UmpgRQCus5oT7MRSrrCsSQIAcuX_CmfJcFNtoTR39FdjnQBXWV0M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddugedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:bThJZb0X2df4wfpWEgzgHfz6mzAssAD19iMH1YtaSuhNWhIgAgtZ_w>
    <xmx:bThJZdGtQvfmghv7M_FNGbUv_Sd9SVyT6ytN_uVL09D0kxEUFR436Q>
    <xmx:bThJZU9kICu66Lgx9IDiC64iIEU8gStoA_ghxsZVGXoiR9nQ5fc-2g>
    <xmx:bjhJZWOMxjbYaRLHIorEfe5laxP8n_iWrFjKULCvETbylyeS5vblzQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Nov 2023 14:03:09 -0500 (EST)
Date: Mon, 6 Nov 2023 11:01:50 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Martincic <pmartincic@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"Michael Kelley (LINUX)" <mikelley@microsoft.com>,
	Boqun Feng <Boqun.Feng@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH] hv_utils: Allow implicit
 ICTIMESYNCFLAG_SYNC
Message-ID: <ZUk4HveGJyao3h5f@boqun-archlinux>
References: <CY5PR21MB366066CE916AEB5289153F09D5DCA@CY5PR21MB3660.namprd21.prod.outlook.com>
 <ZUhByoXhvb3ZowPH@liuwe-devbox-debian-v2>
 <CY5PR21MB3660C276E3A8A20167B7644AD5AAA@CY5PR21MB3660.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR21MB3660C276E3A8A20167B7644AD5AAA@CY5PR21MB3660.namprd21.prod.outlook.com>

On Mon, Nov 06, 2023 at 06:18:48PM +0000, Peter Martincic wrote:
> Sorry for the formatting/recipient/procedure mistakes. I've an updated commit message based on feedback from Michael. I'll wait to hear back from you and Boqun before I post V2/updates.
> 
> Thanks again,
> Peter
> 
> -----Original Message-----
> From: Wei Liu <wei.liu@kernel.org> 
> Sent: Sunday, November 5, 2023 5:31 PM
> To: Peter Martincic <pmartincic@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; Michael Kelley (LINUX) <mikelley@microsoft.com>; Boqun Feng <Boqun.Feng@microsoft.com>; Wei Liu <liuwe@microsoft.com>; Wei Liu <wei.liu@kernel.org>
> Subject: [EXTERNAL] Re: [PATCH] hv_utils: Allow implicit ICTIMESYNCFLAG_SYNC
> 
> On Fri, Oct 27, 2023 at 08:42:33PM +0000, Peter Martincic wrote:
> > From 529fcea5d296c22b1dc6c23d55bd6417794b3cda Mon Sep 17 00:00:00 2001
> > From: Peter Martincic <pmartincic@microsoft.com>
> > Date: Mon, 16 Oct 2023 16:41:10 -0700
> > Subject: [PATCH] hv_utils: Allow implicit ICTIMESYNCFLAG_SYNC
> > 
> > Windows hosts can omit the _SYNC flag to due a bug on resume from 
> > modern suspend. If the guest is sufficiently behind, treat a _SAMPLE 
> > the same as if _SYNC was received.
> > 
> > This is hidden behind param hv_utils.timesync_implicit.
> > 
> > Signed-off-by: Peter Martincic <pmartincic@microsoft.com>
> 
> Boqun, what do you think about this patch?
> 

The patch looks good to me. Peter, feel free to send the V2 and I will
give my Acked-by.

Regards,
Boqun


