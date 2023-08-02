Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F376DB83
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Aug 2023 01:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjHBX3m (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 19:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjHBX3l (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 19:29:41 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB012D49;
        Wed,  2 Aug 2023 16:29:35 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so3740745ad.1;
        Wed, 02 Aug 2023 16:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691018975; x=1691623775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYke0RquRMMaDHwuy7JXT/FNN3dz4DHZ9BvDGxrUwzE=;
        b=gAz/DO3sOzGULRF91+MBvheE21K+bMaWiV1O9X/0ulMxIvvyIpbTjuiwi5zxvNwNz/
         T/sEBNBV5XQQ8xNzylpUyOlld6BAxuUruDDO9wZtywVMh1mgVEVP6J4uySqDFREn3pnC
         P7X8W7TbwP8wrb+NwY9VT9uaz9XZD07veAIA4o4vcCULcd7xcPFRTDnfaMdlg6QWH2C8
         +po0b5hO1xfx/fOdjNw9npkLJ9cqqLGUZo+XYYkw71fYv7f59lYWAX1Qjpj1SQLxiTWV
         cWQ2jPsywzgnAXeqwiY70JEN5eaW3ru/JaetQDdMl/8JtLU0O+lZcsY+Myq2VYhWOFne
         D98w==
X-Gm-Message-State: ABy/qLbWbIE2SFOKbCqlojIkymjPBf2Wa9kbde6i1GkDn7npGNEv+mVk
        j0iWjMlOO77d6aLaX1ZYveUtSOTPhyY=
X-Google-Smtp-Source: APBJJlHLv6hW2xQ/rd0wraIAbW5SRM+B0W5wZONj3B3AZnoKLGGpnuYfwuM0sE77hd/PKc6bOuDitg==
X-Received: by 2002:a17:902:c407:b0:1b9:e241:ad26 with SMTP id k7-20020a170902c40700b001b9e241ad26mr22666798plk.9.1691018974772;
        Wed, 02 Aug 2023 16:29:34 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902da8700b001b8953365aesm12967072plx.22.2023.08.02.16.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 16:29:34 -0700 (PDT)
Date:   Wed, 2 Aug 2023 23:29:28 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] Drivers: hv: vmbus: Remove unused extern
 declaration vmbus_ontimer()
Message-ID: <ZMrm2PQalHMswLpD@liuwe-devbox-debian-v2>
References: <20230725142108.27280-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725142108.27280-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 25, 2023 at 10:21:08PM +0800, YueHaibing wrote:
> Since commit 30fbee49b071 ("Staging: hv: vmbus: Get rid of the unused function vmbus_ontimer()")
> this is not used anymore, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-fixes, thanks!
