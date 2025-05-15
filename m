Return-Path: <linux-hyperv+bounces-5528-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BE3AB8464
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 12:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20E21BC03E9
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 10:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CFA2980DF;
	Thu, 15 May 2025 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSd/qFQu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD272980CD;
	Thu, 15 May 2025 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747306512; cv=none; b=uK+p+Qv+4s2B2A2ymREZmgoqPzf5VUWzJmYGJLtGPWQ2jD6nc9BO0Yik3xXBPBWOVjSXidcAYIjHXyUSnXSJCr0X79v0yQ8KaK7JANjX8dZfpxZQanbF3vTwaC5djV78/hAej0p0BNblxnMnjBCIDMtuqQpQhpSQZE6z4FHAjhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747306512; c=relaxed/simple;
	bh=0zVMfiLdCgCQ+rxSRMVdYIh43lvAH7krScMeUuV+Qzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC4/yMAoTCOIY/TRWc3iNdenTqchd6FiagTJSr+dRWvHsmU3b6PyKEct11yYJ5dgMdXIO36Ky0O0ERBD+VHRo1MSeDFHkQ9qdMip+Pmk1tgo+rsd/xVbfzEUpmjzG/VN0RCL7w7lcOZt66ebOp7qCSQ3oqRK4sJ6skN4VGs8fuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSd/qFQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42668C4CEE7;
	Thu, 15 May 2025 10:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747306511;
	bh=0zVMfiLdCgCQ+rxSRMVdYIh43lvAH7krScMeUuV+Qzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSd/qFQuphEG6eWhbtWWgCwy/eQXz6bnjThDkrpvkiCJLkuhuNvrbLl2m/SQMZJ/+
	 ZD/3pHVfkezQlcDMCv7zYTX1EJDDqTsrIs/isEGcFFdFUkVPAkZV1pNCrBsBn8V2a5
	 iM33Q7LWlUxIo6SN5xdAH9qOnuCzPfgE1T35IdZiF2n4wfd3hA4uDxHtsE4zkhi2Rk
	 WaicIJX/wR7UvZ0GXl/7N8zIbDza2xaVfkNbOZweLr4kkPl51708NAIzzLUlXKJPut
	 lWVVFSq30SWa5NIREbVXPn/W4RvybVRh476wJAUL2c/tIziy3Rc9t4LSVjvQ4QUzxb
	 MyoMRBh5vgItw==
Date: Thu, 15 May 2025 11:55:05 +0100
From: Simon Horman <horms@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 4/5] hv_netvsc: Remove rmsg_pgcnt
Message-ID: <20250515105505.GT3339421@horms.kernel.org>
References: <20250513000604.1396-1-mhklinux@outlook.com>
 <20250513000604.1396-5-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513000604.1396-5-mhklinux@outlook.com>

On Mon, May 12, 2025 at 05:06:03PM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> init_page_array() now always creates a single page buffer array entry
> for the rndis message, even if the rndis message crosses a page
> boundary. As such, the number of page buffer array entries used for
> the rndis message must no longer be tracked -- it is always just 1.
> Remove the rmsg_pgcnt field and use "1" where the value is needed.
> 
> Cc: <stable@vger.kernel.org> # 6.1.x
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Reviewed-by: Simon Horman <horms@kernel.org>


