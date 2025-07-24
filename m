Return-Path: <linux-hyperv+bounces-6384-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C967B1139F
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Jul 2025 00:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5061CE0783
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 22:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68852367D3;
	Thu, 24 Jul 2025 22:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="clFTFPC8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F8B19B5A7;
	Thu, 24 Jul 2025 22:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395140; cv=none; b=dTcjgdktSC0k17AAMj57nESlfLM3rbJhuUlP/5Ipi3vU830eXCSUuRbqInZNDMEV9UoJgzGq47Hu3pzgUq+3LUNEFPj48tIdpAD20v6ApJhU64KgoIR9pcQa32XlEFg6Tjsrov4pFttPjAleN+qEWYPk3N/Kb+xv/P14UuiOYPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395140; c=relaxed/simple;
	bh=EcMFk0UX4Rc9+HcHnhn2dSajJqdNOWxONWrXdZySm/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fNcUSy2vYN8L3jUOCAaLUJ10x32GtvldELBH7fxXJZO7gHCAgTiq+84zjbwszFV0qcW3lsH4JEAOfaItgSGeiGHsdTkv18tF+ni5FFluBtaoQd0UmSVwLyxolXJbetwY1GBuo0zm/Rv6EdONefSecDFNILBA0fg0VxIH0hF+o/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=clFTFPC8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 8A0882021860; Thu, 24 Jul 2025 15:12:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A0882021860
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753395133;
	bh=EcMFk0UX4Rc9+HcHnhn2dSajJqdNOWxONWrXdZySm/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=clFTFPC8G/Gid3451vr8ykaE6/2gyueX88SghUSUIdegQYK31nWcYFjLxDmLlT0M5
	 VGqhnTwxiXEadjpvUL5M/apgbrP7cdDNT5c3J1StfACjAmaA+UWjqL8kOh4fQ+PbPq
	 SsciIE8lL3hJVASXSpKqt6ZnrBpykUu5xL2m6XJk=
From: Hardik Garg <hargar@linux.microsoft.com>
To: krzk@kernel.org
Cc: apais@microsoft.com,
	cho@microsoft.com,
	conor+dt@kernel.org,
	decui@microsoft.com,
	devicetree@vger.kernel.org,
	haiyangz@microsoft.com,
	hargar@linux.microsoft.com,
	hargar@microsoft.com,
	krzk+dt@kernel.org,
	kys@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	ssengar@linux.microsoft.com,
	wei.liu@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: microsoft: Add vmbus message-connection-id property
Date: Thu, 24 Jul 2025 15:12:13 -0700
Message-Id: <1753395133-26061-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <6d3b5d1e-de1b-4d3b-ba14-7029c51b8e05@kernel.org>
References: <6d3b5d1e-de1b-4d3b-ba14-7029c51b8e05@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Then all guests can use the same value, 0, making this property redundant.

No, they cannot use the same value. The protocol requires different connection IDs for different communication paths.
For example, a guest communicating with a VTL0 control plane uses a different connection ID than one communicating with
a VTL2 control plane. The host specifies this value based on the guest's configuration, and there is no other discovery
method available to determine the correct connection ID.

> So not suitable for DT. DT is a static data. You cannot just keep changing existing DT to match whatever you want runtime.

From the guest's perspective, this data is completely static - it doesn't change over the lifetime of the guest.
The guest always looks it up in DT. The hypervisor merely populates this value in the guest's DT. Once set, it remains
fixed for that guest instance, so this data is not dynamic, it's completely fixed for the guest.




Thanks,
Hardik

