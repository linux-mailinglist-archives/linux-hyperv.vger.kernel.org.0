Return-Path: <linux-hyperv+bounces-5502-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75878AB6367
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 08:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C92E16E3E0
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 06:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9324F207DF3;
	Wed, 14 May 2025 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH8hEszT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6162D202C48;
	Wed, 14 May 2025 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747205025; cv=none; b=tuOimvVqNjpoNKpcwbWTvwsAGEWTR0ZiaElKN3nBETbM+7dMo9oJ2n5x6QBAIuIHZwP1oDWLKWlP9evQwG6j/zyua8XDFjD7Dlv6zhmi/aWRr+mZq8HkY2dSHjX0xjWubIGFuz1fZSlTq3hKGGY+7kNLsS14MCkOnKqwWYSAB4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747205025; c=relaxed/simple;
	bh=/eoA5dRABAipZwS2W69m2xusqSWbSukOX37lspQwxio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPdsdrMkvdCN/IeGuZ6AHfIXfyXWm9/2BSLNWDlkNqfRX4gjJiGJXPsytB0HcJxQ9dLg/ppdSJX8dAGcce8hPT3oUltPxYxFQ4VUOfz5bXTXYq+fj6m/wgpKDIcZuXk4vokwJEL9jqgDc45iKTuKHFEFEfFxxf8nopRtU1JtOZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH8hEszT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E58C4CEF1;
	Wed, 14 May 2025 06:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747205024;
	bh=/eoA5dRABAipZwS2W69m2xusqSWbSukOX37lspQwxio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DH8hEszTfhPNBZsTgxUhCicwevzYt8FEfgGsdStnQDZSAjbbqBpLqTdGSLohfY/vE
	 mVduQP6eLlGxuB5xdGMRRRacNloj0e7GQzlbMRSTqJfgHnr+cf1qaMqp3HbJC+Ne/N
	 QOSvuCTx79v4PBj5rnYiZA3Huf+1WcvkxeGwIJkiCQb4oRkl0SBl0AY8+7B0MG5jRV
	 6OUlpCxtyyxDZC8QPATKQN8ataRqQ3YsAatJfD8fHEXIoPA9HEE6KRO+qyrd10LCqB
	 7qYTK8LdZB0+UQxkAg3m1ImElPA5pkO4cy18VZ5GA6H14XB/MLM6Ezj22R/FeBV589
	 JXdjipGWmPj7g==
Date: Wed, 14 May 2025 06:43:43 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, gustavoars@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: hv: Remove unnecessary flex array in struct
 pci_packet
Message-ID: <aCQ7n4U55j6dvkzl@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250514044440.48924-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514044440.48924-1-mhklinux@outlook.com>

On Tue, May 13, 2025 at 09:44:40PM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> struct pci_packet contains a "message" field that is a flex array
> of struct pci_message. struct pci_packet is usually followed by a
> second struct in a containing struct that is defined locally in
> individual functions in pci-hyperv.c. As such, the compiler
> flag -Wflex-array-member-not-at-end (introduced in gcc-14) generates
> multiple warnings such as:
> 
> drivers/pci/controller/pci-hyperv.c:3809:35: warning: structure
>     containing a flexible array member is not at the end of another
>     structure [-Wflex-array-member-not-at-end]
> 
> The Linux kernel intends to introduce this compiler flag in standard
> builds, so the current code is problematic in generating these warnings.
> 
> The "message" field is used only to locate the start of the second
> struct, and not as an array. Because the second struct can be
> addressed directly, the "message" field is not really necessary.
> Rather than try to fix its usage to meet the requirements of
> -Wflex-array-member-not-at-end, just eliminate the field and
> either directly reference the second struct, or use "pkt + 1"
> when "pkt" is dynamically allocated.
> 
> Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Queued. Thanks.

