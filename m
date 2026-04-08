Return-Path: <linux-hyperv+bounces-10062-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDZ+GqSu1Wkj8wcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10062-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 03:25:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2D73B5EA0
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 03:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2E1E301BC0D
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 01:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E863A342523;
	Wed,  8 Apr 2026 01:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="flveBzOo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3D533FE27;
	Wed,  8 Apr 2026 01:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775611552; cv=none; b=fW2Bl5E4vqUVI1xfa0mlSubKQ0tY/RxoJDdkvysmHXGN6UJZiKPXyTyfnTQYDu5r0ZW96QiCmNMrMmhFD7s3jgiAHJvRSgjleTE80TjiDhIhCWqbKyPKqjZfYlvtVDAHOh+92hM4+/zd+B+zXj6Swj4pdEyBgwlyG8WDMgZGAmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775611552; c=relaxed/simple;
	bh=k8oSfGzW1JwXiW9u21iFVj0cUB4fPWfPkFGrSbas+z0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CqAfyxsV0ABG7R7NqpWs90zPnMIB2zztkKln29MGirxTQPOQ0ARpr1nJ4GmSC1Og6saRo16DsgJpLinvmAfqciQBYsjSWIM0CeqiT9sexUkFb3jmoIpz6qdRcYclSyMUfBQ+l2bL/XtmpBywlc2kj7Z0+KnxYT/jIEjFLxUHK+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=flveBzOo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 83CD520B710C; Tue,  7 Apr 2026 18:25:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 83CD520B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775611551;
	bh=k8oSfGzW1JwXiW9u21iFVj0cUB4fPWfPkFGrSbas+z0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=flveBzOorCkrW9UFg61nx2QHogmEFyttC4VFmyArghUAvkoZuNoKl2ChjtlE8HvUB
	 GPdzy2U4BWPGpKHdnZ8etwNKXSjXdojw5YjHvry0xyoz9RnS1AcIn9QNK+iACx60Wr
	 LgOpi4NzE3kYb8NVH09abcSOAQGkkq8G/+f1f+io=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 7FBA130705A5;
	Tue,  7 Apr 2026 18:25:51 -0700 (PDT)
Date: Tue, 7 Apr 2026 18:25:51 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
cc: linux-hyperv@vger.kernel.org, x86@kernel.org, 
    "K . Y . Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
    Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org, 
    linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 5/6] mshv: clean up SynIC state on kexec for L1VH
In-Reply-To: <20260406-hasty-academic-hippo-a4cfb8@anirudhrb>
Message-ID: <ed5ff5-8e5d-5dea-5170-3639a33c7dc8@linux.microsoft.com>
References: <20260403190613.47026-1-jloeser@linux.microsoft.com> <20260403190613.47026-6-jloeser@linux.microsoft.com> <20260406-hasty-academic-hippo-a4cfb8@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com];
	TAGGED_FROM(0.00)[bounces-10062-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C2D73B5EA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 6 Apr 2026, Anirudh Rayabharam wrote:

> I believe this code has moved to mshv_synic.c in hyperv-fixes. So, this
> probably won't apply.

Right, this needs a fix.

Best,
Jork

