Return-Path: <linux-hyperv+bounces-359-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 825B77B3E94
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Sep 2023 08:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 35589281C09
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Sep 2023 06:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B57A3FE3;
	Sat, 30 Sep 2023 06:09:23 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B361FA8;
	Sat, 30 Sep 2023 06:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2656CC433C7;
	Sat, 30 Sep 2023 06:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696054162;
	bh=uvjHAVtyz+cMLlBpiml8y8WpVPimcnEoijVRbGSv7y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YyRBlWndR3KwVIYMarncmB/ymR7JLJrQUvl56+M+guaafrMTYE6eV9jnmINKz1Ngd
	 mG2z7FNLyoFAkJfsX7netdXC6W9z6m+MOIPOY+TYgwcq12c5WGHsbQcBJT/2AvLXcJ
	 ySpfKlnuIVN74VanHAw/DkBr+ZnInv5wVMyFTt3Q=
Date: Sat, 30 Sep 2023 08:09:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, patches@lists.linux.dev,
	mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
	haiyangz@microsoft.com, decui@microsoft.com,
	apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
	ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
	stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
	vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v4 13/15] uapi: hyperv: Add mshv driver headers defining
 hypervisor ABIs
Message-ID: <2023093057-eggplant-reshoot-8513@gregkh>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>

On Fri, Sep 29, 2023 at 11:01:39AM -0700, Nuno Das Neves wrote:
> These must be in uapi because they will be used in the mshv ioctl API.
> 
> Version numbers for each file:
> hvhdk.h		25212
> hvhdk_mini.h	25294
> hvgdk.h		25125
> hvgdk_mini.h	25294

what are version numbers?

> These are unstable interfaces and as such must be compiled independently
> from published interfaces found in hyperv-tlfs.h.

uapi files can NOT be unstable, that's the opposite of an api :(

> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Acked-by: Wei Liu <wei.liu@kernel.org>
> ---
>  include/uapi/hyperv/hvgdk.h      |   41 +
>  include/uapi/hyperv/hvgdk_mini.h | 1076 ++++++++++++++++++++++++
>  include/uapi/hyperv/hvhdk.h      | 1342 ++++++++++++++++++++++++++++++
>  include/uapi/hyperv/hvhdk_mini.h |  160 ++++
>  4 files changed, 2619 insertions(+)
>  create mode 100644 include/uapi/hyperv/hvgdk.h
>  create mode 100644 include/uapi/hyperv/hvgdk_mini.h
>  create mode 100644 include/uapi/hyperv/hvhdk.h
>  create mode 100644 include/uapi/hyperv/hvhdk_mini.h
> 
> diff --git a/include/uapi/hyperv/hvgdk.h b/include/uapi/hyperv/hvgdk.h
> new file mode 100644
> index 000000000000..9bcbb7d902b2
> --- /dev/null
> +++ b/include/uapi/hyperv/hvgdk.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: MIT */

That's usually not a good license for a new uapi .h file, why did you
choose this one?

> +/* Define connection identifier type. */
> +union hv_connection_id {
> +	__u32 asu32;
> +	struct {
> +		__u32 id:24;
> +		__u32 reserved:8;
> +	} __packed u;

bitfields will not work properly in uapi .h files, please never do that.

thanks,

greg k-h

