Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC39B5E7720
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Sep 2022 11:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiIWJ3f (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Sep 2022 05:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiIWJ2r (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Sep 2022 05:28:47 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B64F5971;
        Fri, 23 Sep 2022 02:28:17 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id bq9so19513496wrb.4;
        Fri, 23 Sep 2022 02:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=fI2lO/p0Tgu9FuD6GUmjhPF/627CFAkNm/iJ5jz3IKc=;
        b=DPPARzT2KsWkpAqZByKqbenZPdTtt7JMVUAhHmIRRuZtefqceyw28bepsGXPGgvvTp
         ZaHkoJcicTOUzneNZRzgQQuQSjHVFOCg7oQkVYoPOcMyJxwkxycB6IfK/RnXVV9hJRcW
         pjjKIbQjWfZRJe2wl/ZKxey3x5IfsHBnBAAg9GcBKEyYEU0FX+d91+I9QSFX0qcJUgOM
         52COLBcsXX2CwRmO2y3Se9DolCtqxGUgtpVfe7t5XS53lFNDPJAEHqq50MWT2eHgCCyX
         2WdgoM+TR2U35oUxb+fImuifYIzIYcseqOJktiPwprIlfk2pbR+62jK5sV8Z3MG8ZUtz
         Kllg==
X-Gm-Message-State: ACrzQf3rcGcJjWjvKhRkejowv4qNoD/mdX7z3/W68fUH/U3PvDo9I2yX
        B9MFuxDKZ8mhu/TCfMucEYU=
X-Google-Smtp-Source: AMsMyM6d4MFsmIRMHMVoz1pAsgjMy4X3kVPesZ4ZQ1zGtKpyqvBlXnSQrg3dQn54qGcGLUueJdZg9g==
X-Received: by 2002:a5d:574a:0:b0:228:b90c:e5ee with SMTP id q10-20020a5d574a000000b00228b90ce5eemr4546269wrw.328.1663925279780;
        Fri, 23 Sep 2022 02:27:59 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d4206000000b0022b315b4649sm3628846wrq.26.2022.09.23.02.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 02:27:59 -0700 (PDT)
Date:   Fri, 23 Sep 2022 09:27:57 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Optimize vmbus_on_event
Message-ID: <Yy18HV8iAFLhF3P/@liuwe-devbox-debian-v2>
References: <1658741848-4210-1-git-send-email-ssengar@linux.microsoft.com>
 <20220815153141.x7q6qryxv25gvjgy@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815153141.x7q6qryxv25gvjgy@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 15, 2022 at 03:31:41PM +0000, Wei Liu wrote:
> On Mon, Jul 25, 2022 at 02:37:28AM -0700, Saurabh Sengar wrote:
> > In the vmbus_on_event loop, 2 jiffies timer will not serve the purpose if
> > callback_fn takes longer. For effective use move this check inside of
> > callback functions where needed. Out of all the VMbus drivers using
> > vmbus_on_event, only storvsc has a high packet volume, thus add this limit
> > only in storvsc callback for now.
> > There is no apparent benefit of loop itself because this tasklet will be
> > scheduled anyway again if there are packets left in ring buffer. This
> > patch removes this unnecessary loop as well.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> 
> Unfortunately this missed the recent merge window so it will be picked
> up for the next release.
> 

Applied to hyperv-next. Thanks.
