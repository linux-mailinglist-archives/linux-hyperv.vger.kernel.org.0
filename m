Return-Path: <linux-hyperv+bounces-7147-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AC6BC6CEC
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Oct 2025 00:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C903C7AEB
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Oct 2025 22:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1C12C21E5;
	Wed,  8 Oct 2025 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qi7JBrye"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0622C21CF;
	Wed,  8 Oct 2025 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759963436; cv=none; b=lF8NUPSxa2v0eZAaZuMaOvC0YBNZz6uZGIiE/fYVJQxUsJJ5MGSPMndBg9D4GivW40kkMpTlCy4UhhG3Z92kIP133CJogbpdjOMHwwzgeQqvXnIkd4YIaMA0gfh1Xlg3CeloqnGmp8FldPuvsbZI1F3ZVOHwdVIJzZSPlFmm0v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759963436; c=relaxed/simple;
	bh=JoQ9cIyiKqjzBd1Wubf0x85PFpoY7gElHhkRO1LMxT4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRECKi5OmGoFX7xGsomI9nzX2hh9h0QKKDy1KWZVTT1WivyibgmdQ4+G/g8ZmaXcjexm7Q+if8aJEmVSYSZXPB1Ln4GgqcyT66X2MvSOCFCJs7ZnGid19Q9hg4YH2Obb0yojrP9xPWOSEqv+W7iHzQCm4MudQgRbMjolO29Gkrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qi7JBrye; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.10.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id C49DE2038B7E;
	Wed,  8 Oct 2025 15:43:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C49DE2038B7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759963434;
	bh=JoQ9cIyiKqjzBd1Wubf0x85PFpoY7gElHhkRO1LMxT4=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=qi7JBrye+ZgvxM2wgtjgc4m+kp9x9nOAyIhJNkYTzqNHwrYHf2DYEQmMne1mkB5va
	 QfN7T5XbkT7WXdH/1u8vbz6tC3TNaBvsNh80yhTV/5FufYD5UNEcYKTzfPNCGX2OlU
	 ZeN+P9lxPuY5H/2s2G0tIG2AH+kSNndw86MqZW0I=
Date: Wed, 8 Oct 2025 15:43:53 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH
 --to=kys@microsoft.com,haiyangz@microsoft.com,wei.liu@kernel.org,decui@microsoft.com]
 Drivers: hv: Resolve ambiguity in hypervisor version log
Message-ID: <aObpKYXKbc9D8fuM@skinsburskii.localdomain>
References: <175996333379.107949.887881974668560955.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175996333379.107949.887881974668560955.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

Please disregard


