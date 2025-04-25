Return-Path: <linux-hyperv+bounces-5141-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F4FA9CAFD
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 16:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE6F1BC7B8B
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DAE24C07A;
	Fri, 25 Apr 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vOXsEYhX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01D224A04A;
	Fri, 25 Apr 2025 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745589652; cv=none; b=M6nQhmY4M/4Valj9Y+GfuSvfwjQMSQqc4dgc4LE880xtnkkH9Ps8HR7q6O9QL0RoFReUsBKu/yzLzH8A1Zi//SzNVnXTCd0a4Go5KNUWzXZfI4J7oWmaQgxI3FqJwb0DMu4v4SfyJQmyW3LwL8sJT9AmIUog8psP1mh0lRxj6V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745589652; c=relaxed/simple;
	bh=K7ha7zQ4kuUqZlAccWLjh64//h7Ka5YcUpqWJSjkXpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdATqXs6uF6KqdHZlmG/pAyEvlEOg7oqu+rTq78OyjhG8GUbqQ2WZngDlVwqVlqFu35kJ7vPGUXFQu0gG7vz1JiNLKGKHyrMu+IT0ucR8ctVPoWrg5O9Ux8oy+Ezl41d0MUEXJfFH4HLQXxY8krQ1SIzgciE3rHv0xKJ7tMgCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vOXsEYhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A621FC4CEE4;
	Fri, 25 Apr 2025 14:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745589651;
	bh=K7ha7zQ4kuUqZlAccWLjh64//h7Ka5YcUpqWJSjkXpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vOXsEYhXaxFQuIyhUSSa8J3DYEwRCjOWrvu9oxuhgdyRlvhh2KSCcXTe5WCfqvd1g
	 tRI2v/jBJN94rzXHZNfqnDvZQZ6GhZVWQ3crsPgT3wngYt7k5FWm7fM7qdu9XllADJ
	 tc0NX2Km1CMq0y35GJ2VxX7suK3ALohiAa1nrT0g=
Date: Fri, 25 Apr 2025 16:00:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 0/2] uio_hv_generic: Fix ring buffer sysfs creation
 path
Message-ID: <2025042501-accuracy-uncombed-cb99@gregkh>
References: <20250424053524.1631-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424053524.1631-1-namjain@linux.microsoft.com>

On Thu, Apr 24, 2025 at 11:05:22AM +0530, Naman Jain wrote:
> Hi,
> This patch series aims to address the sysfs creation issue for the ring
> buffer by reorganizing the code. Additionally, it updates the ring sysfs
> size to accurately reflect the actual ring buffer size, rather than a
> fixed static value.
> 
> PFB change logs:
> 
> Changes since v5:
> https://lore.kernel.org/all/20250415164452.170239-1-namjain@linux.microsoft.com/
> * Added Reviewed-By tags from Dexuan. Also, addressed minor comments in
>   commit msg of both patches.
> * Missed to remove check for "primary_channel->device_obj->channels_kset" in
>   hv_create_ring_sysfs in earlier patch, as suggested by Michael. Did it
>   now. 
> * Changed type for declaring bin_attrs due to changes introduced by
>   commit 9bec944506fa ("sysfs: constify attribute_group::bin_attrs") which
>   merged recently. Did not use bin_attrs_new since another change is in
>   the queue to change usage of bin_attrs_new to bin_attrs
>   (sysfs: finalize the constification of 'struct bin_attribute').

Please fix up to apply cleanly without build warnings:

drivers/hv/vmbus_drv.c:1893:15: error: initializing 'struct bin_attribute **' with an expression of type 'const struct bin_attribute *const[2]' discards qualifiers in nested pointer types [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
 1893 |         .bin_attrs = vmbus_chan_bin_attrs,
      |                      ^~~~~~~~~~~~~~~~~~~~
1 error generated.

