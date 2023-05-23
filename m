Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A032670E4E8
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 May 2023 20:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbjEWSwC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 May 2023 14:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjEWSwB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 May 2023 14:52:01 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD0791;
        Tue, 23 May 2023 11:52:00 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-64d1e96c082so93419b3a.1;
        Tue, 23 May 2023 11:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684867920; x=1687459920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oG31BoHoHiHwOlqYGhtkonFmlXgV+FoMl6Z765+ow0=;
        b=PBKPsxUEIsqLgyqpBgTHG27FPe/tRDyDh2aNmMcKYOchx6xKQ+FTFyrPkZaIiwnmjO
         yLaS+ZqGRcYyfQsFAiRvjSRHf8b20Ez6mZNq4S6rFOLwA15KFaI1XL8F/i6maGjWPLoi
         sX+ufG8fh30dgxBta1KJSYJbwgmqsTJ5NWrcpCzD2P4Y7r3oQjcE1MpTXnICDXjmptfi
         LS4g3HlL2lYkSAXFBy7F55WCvrr3j0sIrhWsNi3wpRoVgJy83kh8gPavqjAWlZ/4S4Wr
         rO3Etz6kI7J41IyDYnrNCr62sEHAbSzkKZx5A2dl/g0xgarf44eb45ErmQayYwCjFiOB
         H9yg==
X-Gm-Message-State: AC+VfDwb9Ks03CmlZy7ItXUF0bD5XjK17QtK/nzswlYXK4ZXrMDiEeDR
        Izs6JatqjVAZlCFWhgq3LTM=
X-Google-Smtp-Source: ACHHUZ5YNdnPd8x4bK04UQx412rlbNvN8OuRKTB5AGhP622dL7WqYAj832Ewisttkrnv0+SzatUQVw==
X-Received: by 2002:a05:6a21:7886:b0:10b:b6cf:bbb0 with SMTP id bf6-20020a056a21788600b0010bb6cfbbb0mr8498025pzc.42.1684867919866;
        Tue, 23 May 2023 11:51:59 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id b24-20020aa78718000000b0063d2989d5b4sm6112108pfo.45.2023.05.23.11.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 11:51:58 -0700 (PDT)
Date:   Tue, 23 May 2023 18:51:56 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/hyperv: Fix hyperv_pcpu_input_arg handling
 when CPUs go online/offline
Message-ID: <ZG0LTAeV+KMAGXIq@liuwe-devbox-debian-v2>
References: <1684862062-51576-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684862062-51576-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 23, 2023 at 10:14:21AM -0700, Michael Kelley wrote:
[...]
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 0f1001d..3ceb9df 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -200,6 +200,7 @@ enum cpuhp_state {
>  
>  	/* Online section invoked on the hotplugged CPU from the hotplug thread */
>  	CPUHP_AP_ONLINE_IDLE,
> +	CPUHP_AP_HYPERV_ONLINE,

x86 maintainers, are you okay with this?

Thanks,
Wei.

>  	CPUHP_AP_KVM_ONLINE,
>  	CPUHP_AP_SCHED_WAIT_EMPTY,
>  	CPUHP_AP_SMPBOOT_THREADS,
> -- 
> 1.8.3.1
> 
