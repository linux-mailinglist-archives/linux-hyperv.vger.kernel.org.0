Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAD35F34B6
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Oct 2022 19:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJCRn5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Oct 2022 13:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJCRnz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Oct 2022 13:43:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E00B165B7;
        Mon,  3 Oct 2022 10:43:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a26so23778968ejc.4;
        Mon, 03 Oct 2022 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xhRHQAWpY9zcvBQxpJPzwuHHSfinpSlWPgDgC2ZgV58=;
        b=DkYYlGKRoFbiDXfpQRtyt/oZtwEN4hxFAU9juGvW+TDFhVpCm5c72fhdOvGGbaXY5Q
         3igGc0ZqeBmP9vMQq6HESQnj6F0aBpDYyPg34oesgocaNJHs8poFpjci7dppmzAvwzX7
         i/m/Tn2domV0Y4O9N32TT5sF2kLQ3E/IfSoNltFJlI1zXT6TVBSddVmGl8OHp5CbU5zh
         4c8kiS5lQXk+IO4Zlq5bhUEhmQ4R6vSnz13cc7si5IN/5gQ3oktsR8hNv+6GsCJzJrel
         6zQ5lGpE5ooNqU2mFyJV43w1cPMz19q5vXCAx/teT9FrVzKmU2D54cpJt7QQqJJ2tGps
         Z4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xhRHQAWpY9zcvBQxpJPzwuHHSfinpSlWPgDgC2ZgV58=;
        b=MP9/N/Olozm4WUGEZNPkYpDkuj97fVPLqrUSHM1SyUP60hJUN0IJd/cveCsh2bn6bm
         AiFUDxyQkC4YQqzP8IC7IXNPB5Ax1zOR3bpVVi2dZairPiZdK/18RhmPJfXxkGd+f3et
         N/hF+oMSAT3RQeuUV3A0q7OoUomPg4/IjHaFkfDYM151Mz52JArVoecGqKZ4x8TdpwDJ
         1D3VavisyZ27xXuVL4YiimCghs6G7Oo3NLJ3FwnVcYPuA5r5ytIX/Rqb9ry3W17bP8BN
         GijA5kC7T8xrRjuePJCmDMoWbyNaL1B5LrSwgiNjjJINvENISIpz+LKr7mlj5nTsZYkv
         TcWA==
X-Gm-Message-State: ACrzQf3bOSRomZWme4lr3eDPc7gsftqvSCdjAopdGHToKowVpolTNeN5
        WxMPBOXolRT4QpFA9IYLx0g=
X-Google-Smtp-Source: AMsMyM5KVfrlTG7a7NloBqmBejm0a0Cp3JGix9Vl9UGlpeJP91ynrWK/3b2GA2UgGDWnGf71N997zA==
X-Received: by 2002:a17:906:db0c:b0:77b:7d7d:5805 with SMTP id xj12-20020a170906db0c00b0077b7d7d5805mr16271979ejb.726.1664819031761;
        Mon, 03 Oct 2022 10:43:51 -0700 (PDT)
Received: from localhost.localdomain (host-79-17-38-224.retail.telecomitalia.it. [79.17.38.224])
        by smtp.gmail.com with ESMTPSA id r2-20020a17090609c200b00730b3bdd8d7sm5831403eje.179.2022.10.03.10.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:43:50 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhao Liu <zhao1.liu@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/hyperv: Replace kmap() with kmap_local_page()
Date:   Mon, 03 Oct 2022 19:43:49 +0200
Message-ID: <21632541.EfDdHjke4D@localhost.localdomain>
In-Reply-To: <20220928095640.626350-1-zhao1.liu@linux.intel.com>
References: <20220928095640.626350-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wednesday, September 28, 2022 11:56:40 AM CEST Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> kmap() is being deprecated in favor of kmap_local_page()[1].
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap's pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and are still valid.
> 
> In the fuction hyperv_init() of hyperv/hv_init.c, the mapping is used in a
> single thread and is short live. So, in this case, it's safe to simply use
> kmap_local_page() to create mapping, and this avoids the wasted cost of
> kmap() for global synchronization.
> 
> In addtion, the fuction hyperv_init() checks if kmap() fails by BUG_ON().
> From the original discussion[2], the BUG_ON() here is just used to
> explicitly panic NULL pointer. So still keep the BUG_ON() in place to check
> if kmap_local_page() fails. 

How might kmap_local_page() return invalid kernel addresses? 

I think that, if this function returns, the pointer is always a valid kernel 
address. Am I missing something?

> Based on this consideration, memcpy_to_page()
> is not selected here but only kmap_local_page() is used.

I can't agree with you, if the premises are that kmap_local_page() might 
provide invalid addresses.

Thanks,

Fabio

> Therefore, replace kmap() with kmap_local_page() in hyperv/hv_init.c.
> 
> [1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com
> [2]: https://lore.kernel.org/lkml/20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2/
> 
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> ---
> Suggested by credits.
> 	Dave: Referred to his comments about whether kmap() can fail and 
the
> 	      suggestion to keep BUG_ON() in place.
> 	Ira: Referred to his task documentation and review comments about
> 	     keeping BUG_ON() for kmap_local_page().
> 	Fabio: Stole some of his boiler plate commit message.
> ---
>  arch/x86/hyperv/hv_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 



