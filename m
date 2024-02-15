Return-Path: <linux-hyperv+bounces-1544-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC24856699
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Feb 2024 15:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0021C22A95
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Feb 2024 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2E712CD98;
	Thu, 15 Feb 2024 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="DfppHzO5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D81433B9
	for <linux-hyperv@vger.kernel.org>; Thu, 15 Feb 2024 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008854; cv=none; b=kg+BlDe40+mpExYFugs/CEOFMyh4M5b7Ed4IpxwwZ+lWF6Jfv4jDSI5Mn3taf6hixJWqmafA9zuk4vCduXCCZnDlRNOt+SXxvmc+h9c1z5f9DOrqHN3pFgInS08CfWaIgX2zNY+ObuKjowk0aqsf1PHdiBkcTavPF7zkqO1PhTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008854; c=relaxed/simple;
	bh=IWvu7cjh5iALLUOxrLDOh5bt2Eq42R3CIryZ9cn+G+k=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uPwgs8DivfXPoFC5sDghnJDOY1qk+2ccyJ7ceSyjF5TRvabrViVoX3JDX5OfjUq7zfi6IA38yxRonl8lWApqwss9NCI5m7vZu5PmM4x0eg51Flpjr4V1iwoavMj/6pJqMNp5S6zerQK/gzM/ECbF1pmNQe2BuYTyGgBahZygL8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=DfppHzO5; arc=none smtp.client-ip=185.70.40.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1708008850; x=1708268050;
	bh=IWvu7cjh5iALLUOxrLDOh5bt2Eq42R3CIryZ9cn+G+k=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DfppHzO5y6cS7mAR7ovg9QvjA3aA0P7FSJBRa/lwiuEP8xC06z/U444J3pO7GeBes
	 eX3lNts2dAwLry5YxLMP1ObHyqFz3uehKz6SbKmvVZVPIpHpbbXSuXbkeRkH7GKscd
	 pJcyM6RcJiHpomjcUXT8PwP7E6vsphn1xG+CrGyiZQ2z49x59nH9r2/Kz1zunkEtRp
	 z8lk4J3mRSTugJj3ozSL/iQWmz+L++og2YnTKRTDz4P7Jt0K40CbA2S8dG7Dg40u8C
	 PJ5lFfM3ANW8x6VU2BpK28c+x80KVfdu5JC33lCrhhethdWCcp6n/ibKRbIXywp9yY
	 QJf3Zmd3Spq2A==
Date: Thu, 15 Feb 2024 14:53:51 +0000
To: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Linux-HyperV
Message-ID: <laZ2x-LorSNJLHlwynewEQdDzEc8fAClk6SrtzuQ8hHU222LPbwIbH3ZuOAwE0RNATnrHYc8q6XkTwHPCyu_bb535uahVHiSUY4qslYUXiQ=@protonmail.com>
Feedback-ID: 39510961:user:proton
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Linux-HyperV

Good day from Singapore,

Is this mailing list related to Microsoft Hyper-V virtualization?

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individual in Singapore
Blogs:
https://tdtemcerts.blogspot.com
https://tdtemcerts.wordpress.com
GIMP also stands for Government-Induced Medical Problems.






