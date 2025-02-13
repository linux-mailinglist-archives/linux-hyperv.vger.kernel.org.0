Return-Path: <linux-hyperv+bounces-3947-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1443A3524A
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Feb 2025 00:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C43188972F
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2025 23:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F291C84D8;
	Thu, 13 Feb 2025 23:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0qAAmH3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3881C84CB;
	Thu, 13 Feb 2025 23:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739490308; cv=none; b=c+9/0iQhQV6pfqDBToe7EJ4dNKMkQUrnDda0DQW7TvkM3jvGo5ce+B3R8evrWschxTj9mU9i05Jfp9saSHBTBIG10nMN982nqIEzlHyEm0lVhR6T964vgRKsYMTs7aD9h76BxZ+s1htuiFRuJVlgwwMPrLj4sUJfo3BQQ68OKFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739490308; c=relaxed/simple;
	bh=XNliIBdQBXEl+OZaXzuFj2IDpDDMZeIyb+Jx2wZuTTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTbOb1sxd25DtzrKpmJCLHkza+FXVdhl+GaXPxR28NEYkk8xxzcyU0xudL5xLfAnwLK+it+bMYO8AAvYW7GrX09OGgFYfnlw7UvrmJ9/o+7L7fjYxPtUgBrHgavGfbPiSK2XmxNsM+lIIffy2PwVpWlQWAb+rt37damop3kwdHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0qAAmH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BE7C4CED1;
	Thu, 13 Feb 2025 23:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739490307;
	bh=XNliIBdQBXEl+OZaXzuFj2IDpDDMZeIyb+Jx2wZuTTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0qAAmH379jMipcCv3Er+MLIRVRoNfSO+RfRNLkHmr7PlTU0ja7EoNIsjfmHKoriS
	 t/2BwCMg/Bm4j4Z0Q5mSqE+gjIJ7TupxqOTjeWPNiivOkVKG8tRfLP1zJUv7O/b1qo
	 HA0a/Tr7cGtVpFiZMCavQEKdo/cHXfh3ePeWka+UBW+N8Crfa/W/Gq9NkP3E1XG3ZI
	 SqL846jxGeXAEwWLh1wFyc7c161Mrpld+0rR3tCHUBk28MAskXwkZg22IHmdz8dtMQ
	 02OvMWCCSYRE6NAFbPsxA/HYMYuGEivCOHDBdWDpMF0etlPBC5ekI5UmriKQ+aAq47
	 3pmLrispOsIGg==
Date: Thu, 13 Feb 2025 23:45:06 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] cpu: export lockdep_assert_cpus_held()
Message-ID: <Z66EApBADzIWAtUn@liuwe-devbox-debian-v2>
References: <20250117203309.192072-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117203309.192072-1-hamzamahfooz@linux.microsoft.com>

On Fri, Jan 17, 2025 at 03:33:06PM -0500, Hamza Mahfooz wrote:
> If CONFIG_HYPERV=m, lockdep_assert_cpus_held() is undefined for HyperV.
> So, export the function so that GPL drivers can use it more broadly.
> 
> Cc: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Series applied to hyperv-next. Thanks.

In the future it is better to write a small cover letter for a patch
series.

Thanks,
Wei.

