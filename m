Return-Path: <linux-hyperv+bounces-5572-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9B0ABD619
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 13:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E399B8A3BD6
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 11:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0059B27CCDF;
	Tue, 20 May 2025 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c1VQSb6w"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C227BF92;
	Tue, 20 May 2025 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739258; cv=none; b=jbRiIuWOtVq0vDCm4nzwnKAO8TEWyIy6YuynOs0jh+2hKXPdhdT29XVhwG2RXiiwBhKKk3W86KYTXkwdbgQcPNxXba8MHHihAPo9bRtSa4LDGEgDQJiwVY+OmkiPidlyc0AKN7oaFmaS7p/4a8du83P+dyHdklBXffjLfFPxwdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739258; c=relaxed/simple;
	bh=DizL0DWZYPRW53JgIYPglAbGVnJvlDBipWQfSU4etlA=;
	h=Message-ID:Date:From:To:Cc:Subject; b=kaRG6NjADkyoVL5ioyboDz6nZiaY5CYJef5ZCSBBIORuk+uE8PoHUlChEaqizvF0UkvfNiFrlmLzWHjGc8pHMs9lurhrNrNrIeoBBEAQvmlQDUnmt0r+XkLv1fET19agz7PZ65PbkPhvHdjHK34T32poRzMUwTRISPHwozDjzws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c1VQSb6w; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=DizL0DWZYPRW53JgIYPglAbGVnJvlDBipWQfSU4etlA=; b=c1VQSb6wMFs81c2V/kQp7xRPDI
	Lc/P6trAyMyOl23tNn2Fz1jcULqKrDky0SCV6Ttb6CM7w1HUP0isSzZQAOd8e93LLwgt0Pd2il57z
	HLjtIMtKRMAnvO1cvKNE3y9B9/dCEEYM6WWERDfLhie0QN5B7U75rcaehvdRDwL7pxHOIblSfCy1a
	91eyssOJUsZEFWwkzLj3TruM3LoBpOlmfrgqknEp7iGQahtXjmH2B41U2J5kL9BDJDkEOBN/K/Zqy
	ZPI2BKCA4Bpo3cvnWC+YL7ZDVMegt5jOHewDQ+NjKiCFgd0pen+RGVimV4hu4GBuqEnPKmvf2CkUQ
	iutXy2ZQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uHKoh-00000000lql-3N0p;
	Tue, 20 May 2025 11:07:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 4A48530026A; Tue, 20 May 2025 13:07:27 +0200 (CEST)
Message-ID: <20250520105542.283166629@infradead.org>
User-Agent: quilt/0.66
Date: Tue, 20 May 2025 12:55:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 kys@microsoft.com,
 haiyangz@microsoft.com,
 wei.liu@kernel.org,
 decui@microsoft.com,
 tglx@linutronix.de,
 mingo@redhat.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 hpa@zytor.com,
 luto@kernel.org,
 linux-hyperv@vger.kernel.org
Subject: [PATCH 0/3] x86/mm: Cleanups
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Hi!

When reviewing fea4e317f9e7 ("x86/mm: Eliminate window where TLB flushes may be
inadvertently skipped") various other issues were raised. None of these are
critical, so here goes.


