Return-Path: <linux-hyperv+bounces-1597-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E816386A1D2
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Feb 2024 22:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80BA11F2395B
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Feb 2024 21:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362ED14EFDB;
	Tue, 27 Feb 2024 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EA9nt06J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BFE2D60B;
	Tue, 27 Feb 2024 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070351; cv=none; b=ntnU2FUcf9BaBWLIjWnWRkVpQ3zx6gS0Kv0aGO0td0UZiQut31R5br9DlhxWV5J4U7HowCw2UV92Rf5QRe8Y3mLlPxcxIchMgJePABeTzTpu0VP0e4UGH6eGdZ7FykCiLFrfDOzwsva5/cYw12/IbIpbY31pCxq44/BagWQToeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070351; c=relaxed/simple;
	bh=Iqcoysv0H73cM/gPT3EjNA8f+wflNLAvMPD1Fa83WeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=L5syVgYtArnwTR26Ppb2R36miTAA4V2cR+5UQwFIHF87/7pLJy+Ns/XvHEIw0rbki2WkofovsluNmEYB7FhCV4MEh4V+o5044/cAPQoliOfVtN8U64wKbtVQOo0AbXazy7Qp9WTcsaUPIhkpepByYFRu07u2+2Psz9Y8xr7un+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EA9nt06J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 63B5E20B74C0; Tue, 27 Feb 2024 13:45:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63B5E20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709070349;
	bh=Iqcoysv0H73cM/gPT3EjNA8f+wflNLAvMPD1Fa83WeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EA9nt06JXaTK7mZ3PS32YT8O1UiMYmVVhBhkleLsjKUcWdh6PkgH1hG5b9ALfH6rE
	 7NjSjKkRYp8aRNlpVYbWuTlF973+xShDVNhEJjz1kzHF27dELsOwR9ck5pjiYKw4dq
	 e4Can4ebxmE2E2kR0SZKKGoRcoHM+tXm6n2VGe84=
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: mhkelley58@gmail.com
Cc: boqun.feng@gmail.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com,
	wei.liu@kernel.org
Subject: [PATCH 1/1] Drivers: hv: vmbus: Calculate ring buffer size for more efficient use of memory
Date: Tue, 27 Feb 2024 13:45:49 -0800
Message-Id: <1709070349-24712-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20240213061959.782110-1-mhklinux@outlook.com>
References: <20240213061959.782110-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Tested-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

