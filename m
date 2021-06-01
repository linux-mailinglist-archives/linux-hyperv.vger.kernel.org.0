Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50622396E6E
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Jun 2021 09:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhFAIBf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Jun 2021 04:01:35 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:56258 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbhFAIBf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Jun 2021 04:01:35 -0400
Received: by mail-wm1-f42.google.com with SMTP id g204so4309796wmf.5;
        Tue, 01 Jun 2021 00:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CILQ1E8wrD9Jkbinxx/OfXZKHdfMjq3mWMgjEeM1HzA=;
        b=NbGXncsrCFRoKuJsUL4Ji7KkegeDuCvEteEZMJM4mJrzvDyR4dlgngYtYNfOFK95/E
         OugetM6pkDsAP8jqguHnv5s8Z2y18jwNGVcB44g7sUsUx5K4im2YIcpimcnSwCbC8SUp
         yn4WJc4i0x9gFHFtYCBWM+sDa8qBH0r+Md5xzMxkSoFV2kFXJOIhGBME6yNRpBT+foQi
         J0hzNYaLknoJCp4HJx+2mCScj4nC+iB66iiK7sU1xmGdrkvcPJgBhIJjufAAp+B4akxY
         BMIpipYtpAXzqniXz4hQoQlpZ0HaONG24mUpW67BocJWclMLS+nSKVEX8x9eYk/hZ9dZ
         SWKw==
X-Gm-Message-State: AOAM530t5DvGiwPmN4g1b1pvprurclAhFAIeQLNHsjwx8PYYa5Mqoh21
        OStEa9I+bQiBffRJJKANLCE=
X-Google-Smtp-Source: ABdhPJwLtKyeA1XzzRsDVWWVRmDoWsG9VPEDykA2DI96Z+qwBn6RfxeP/dleUCPBEnMA+JD2J+ThPA==
X-Received: by 2002:a05:600c:3545:: with SMTP id i5mr3195750wmq.43.1622534393312;
        Tue, 01 Jun 2021 00:59:53 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n6sm16546787wmq.34.2021.06.01.00.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 00:59:52 -0700 (PDT)
Date:   Tue, 1 Jun 2021 07:59:51 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com
Subject: Re: [PATCH 06/19] drivers/hv: create, initialize, finalize, delete
 partition hypercalls
Message-ID: <20210601075951.2ssgwaajo53x2tna@liuwe-devbox-debian-v2>
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1622241819-21155-7-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622241819-21155-7-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, May 28, 2021 at 03:43:26PM -0700, Nuno Das Neves wrote:
[...]
> diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/uapi/asm/hyperv-tlfs.h
> index 72150c25ffe6..8a5fc59bb33a 100644
> --- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
> @@ -101,7 +101,7 @@ union hv_partition_processor_features {
>  		__u64 fsrep_stosb:1;
>  		__u64 fsrep_cmpsb:1;
>  		__u64 reserved_bank1:42;
> -	};
> +	} __packed;
>  	__u64 as_uint64[HV_PARTITION_PROCESSOR_FEATURE_BANKS];
>  };
>  
> @@ -111,7 +111,7 @@ union hv_partition_processor_xsave_features {
>  		__u64 xsaveopt_support : 1;
>  		__u64 avx_support : 1;
>  		__u64 reserved1 : 61;
> -	};
> +	} __packed;
>  	__u64 as_uint64;
>  };
>  
> @@ -119,6 +119,6 @@ struct hv_partition_creation_properties {
>  	union hv_partition_processor_features disabled_processor_features;
>  	union hv_partition_processor_xsave_features
>  		disabled_processor_xsave_features;
> -};
> +} __packed;

These hunks should have been squashed to the previous patch. They don't
belong here.

Wei.
