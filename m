Return-Path: <linux-hyperv+bounces-2663-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDD794541E
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 23:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DA9285873
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 21:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EA414A4D4;
	Thu,  1 Aug 2024 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KTiybXoa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAEC17579;
	Thu,  1 Aug 2024 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722547875; cv=none; b=mwALZvvNVAUO6g+dfIig4kXkchmyTwjQoxcs4HJ7neQr/KVsUwf8D4uPtUL8OjIwRcdHzQApBoLtBY05/1AEyxBJ4rCuNa7kboFxAOE4yPlEcDiVkBUaFJpcU41QtN5vQvUgi9NT097FH1+xPyMrSyuDdJNuvDep3KZLtOqfOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722547875; c=relaxed/simple;
	bh=7sEApDYX+kzn5hb+O1XYmVtR7YBhdoD/zTVlcvwpS20=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=XSR5NZgclUQjFBXrdNlx8KFRp6Z0pOK1uN/dObexLxLZ2MZMMYThf1GBl8M55DNO74cqIJKNvcTw8b2mAL9Hwri62mKBih1xS+jxbwCwjw7cZQEA4clYnMvFCjaXLPknE7jDoPsmQM1GTM7Dqw7sZUU95IY2xBwb+265Mcr5gLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KTiybXoa; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:To:From:Date:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=7sEApDYX+kzn5hb+O1XYmVtR7YBhdoD/zTVlcvwpS20=; b=KTiybXoaFG7Yk+2oeoaVFwJg3S
	dbHUZLa0SQ0yermKHSEE9uA8Y3Wwp0L7is502ogtSxC1e62GeZCGPCil789enTfEQxgUNcDmAGmNT
	+M3CUdqzf21AgY+ryHwpW19GvYPvh5nwTT/yr/kglUOBGSheTmQ9Puwwp4gYyNPOcPXfFEx5OSxyL
	G8tpa0Vpowg48y6Gj0WTrSigu2l2fwQf9HJSVbMbDsKKKTffunHp8Fizhqkpnsk7C5E934YpgVHTs
	wR0zhWo5ZUgA1oTSLSvTqqa1eVFjwmpj0JaN87IoIxJfz3pXOtSmHDMf1AfopFMnb5Xl//L2z3l2v
	hf2eWN2g==;
Received: from [2001:8b0:10b:5:4def:d905:9693:de2e] (helo=[IPv6:::1])
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZdO1-00000005Zvf-11JU;
	Thu, 01 Aug 2024 21:31:01 +0000
Date: Thu, 01 Aug 2024 22:31:01 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>, lirongqing@baidu.com, seanjc@google.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_clockevents/drivers/i8253=3A?=
 =?US-ASCII?Q?_Do_not_zero_timer_counter_in_shutdown?=
User-Agent: K-9 Mail for Android
In-Reply-To: <871q382b0v.ffs@tglx>
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com> <87ttg42uju.ffs@tglx> <e9a9fb03a4fd47ebddc3bf984726c0f789d94489.camel@infradead.org> <87ikwk2hcs.ffs@tglx> <cf5bf4eec7cb36eec0b673353ff027bee853dd48.camel@infradead.org> <87a5hw2euf.ffs@tglx> <bb8c97ea2b3596f605b9e1b27a221a1c64727e59.camel@infradead.org> <871q382b0v.ffs@tglx>
Message-ID: <1508F48A-DCCF-4AF6-8CA3-109B289E98B2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 1 August 2024 22:22:56 BST, Thomas Gleixner <tglx@linutronix=2Ede> wrote=
:
>On Thu, Aug 01 2024 at 21:49, David Woodhouse wrote:
>> On Thu, 2024-08-01 at 22:00 +0200, Thomas Gleixner wrote:
>>> > I justify my cowardice on the basis that it doesn't *matter* if a
>>> > hardware implementation is still toggling the IRQ pin; in that case
>>> > it's only a few irrelevant transistors which are busy, and it doesn'=
t
>>> > translate to steal time=2E
>>>=20
>>> On real hardware it translates to power=2E=2E=2E
>>
>> Perhaps, although I'd guess it's a negligible amount=2E Still, happy to
>> be brave and make it unconditional=2E Want a new version of the patch?
>
>Let'ss fix the shutdown sequence first (See Michaels latest mail) and
>then do the clockevents_i8253_init() change on top=2E

Makes sense=2E


