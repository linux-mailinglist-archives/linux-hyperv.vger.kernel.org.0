Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658005931D6
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Aug 2022 17:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiHOPbs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 15 Aug 2022 11:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiHOPbr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 15 Aug 2022 11:31:47 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD7BDF67;
        Mon, 15 Aug 2022 08:31:45 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id r83-20020a1c4456000000b003a5cb389944so4062993wma.4;
        Mon, 15 Aug 2022 08:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gonRmhzBVac2V2N8Fv8ujJ3D6QMP5i+tjLo2hj32lw4=;
        b=gLTMRlI1B9Zpx08oiE9+slu2AbGchKdVomj+2n3wcCgY6pOtB4wbM6WFtZ2pxZTwkY
         iy4731K+79Hu6KikJDW7t6bhyKSDmlTeSlsqGz/qyhWKASosak1qae67mW/sLHWxcQzq
         +u0QRHtsDROcsuYxoMj/WswqoO4hzzOzKCVtmJYMZCA/rSp0atM1q+LAzVpGk+4CioHN
         AcMzlxFI8RRZmVxYO380WBVqDSrQRO7t+A9EohJLOa6GUw937NJd7LyqKV6RDgG/HUQk
         BkLVe9jSDXLlE3LqHLO096QSq+ck8+K98WjPSkAPg3WNtm3h9CrEkLFUphO2rNI3AANG
         bJQA==
X-Gm-Message-State: ACgBeo1DpgbFY2M5HAAmyMTckr7dcMTbKaNQ9F1VtnwkwfUy+QW7G0du
        w230guKmfJiVA11IgeaXBIU=
X-Google-Smtp-Source: AA6agR5L79QLI3YGa5B+0m46Py2UasglBE8LXVeQJmSlHlqi/6hGb0xgT4cwr3okO/5JqqMnu/q+rA==
X-Received: by 2002:a7b:ca58:0:b0:3a5:3c1c:6d71 with SMTP id m24-20020a7bca58000000b003a53c1c6d71mr17045618wml.118.1660577503668;
        Mon, 15 Aug 2022 08:31:43 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o30-20020a05600c511e00b003a5dde32e4bsm9494372wms.37.2022.08.15.08.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:31:43 -0700 (PDT)
Date:   Mon, 15 Aug 2022 15:31:41 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Optimize vmbus_on_event
Message-ID: <20220815153141.x7q6qryxv25gvjgy@liuwe-devbox-debian-v2>
References: <1658741848-4210-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658741848-4210-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jul 25, 2022 at 02:37:28AM -0700, Saurabh Sengar wrote:
> In the vmbus_on_event loop, 2 jiffies timer will not serve the purpose if
> callback_fn takes longer. For effective use move this check inside of
> callback functions where needed. Out of all the VMbus drivers using
> vmbus_on_event, only storvsc has a high packet volume, thus add this limit
> only in storvsc callback for now.
> There is no apparent benefit of loop itself because this tasklet will be
> scheduled anyway again if there are packets left in ring buffer. This
> patch removes this unnecessary loop as well.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Unfortunately this missed the recent merge window so it will be picked
up for the next release.

Thanks,
Wei.
