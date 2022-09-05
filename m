Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6D05AD7CE
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Sep 2022 18:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiIEQqK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Sep 2022 12:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiIEQpz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Sep 2022 12:45:55 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9623057F
        for <linux-hyperv@vger.kernel.org>; Mon,  5 Sep 2022 09:45:43 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso5983451wmr.3
        for <linux-hyperv@vger.kernel.org>; Mon, 05 Sep 2022 09:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=WDCHNZckHR+DlWIHVu0VCCHIU3/OL8XwvFYMQpFhxxw=;
        b=6uaeWVw2Xv23+uQ8/gu+38Zj/IRQ/Jaw9KhuZZ6t0f+4kl0MEU7NJ9Gh1VQyzSpFzJ
         muULGithgZ9stnWT7kngZHxkQnSMVoJrr33z1k2SIljY5Owj/PqxXqU6X/cGkyChdcTJ
         UkqR1VSctVrlNz4IJQa8Jq4Su0faQwVQ4wj1aOQKcfpiTByw+1d9XS2OhWYSfiq/Eo/O
         16cNPDq9snRwwAFggUltRerwxGbzuZh+HwyvwbU2FWJLAE4TNq/sLVdMEiqTy8qJMIYO
         02Ldh5EgO/R2YCz0aQthnLiAFtEYUWQvPCMLtnVBnWMZ4ajnCS3pKamtuibIgw5sN2aM
         cbxQ==
X-Gm-Message-State: ACgBeo3EY/2aFE/ObG26O6LKr7FFFkVmVGr2ZEoasNq6r68j7TrD0wHz
        VpMuAF8zGF1N3VhPp+i6+lE=
X-Google-Smtp-Source: AA6agR4cQiSyEclMUcihlFSVOnn6upz1W3Sx3FNK8XKb/I+33imhiqNy8BJEDtXXgQ5XUgW9MyXJQQ==
X-Received: by 2002:a05:600c:1497:b0:3a5:f608:d765 with SMTP id c23-20020a05600c149700b003a5f608d765mr10772753wmh.19.1662396341667;
        Mon, 05 Sep 2022 09:45:41 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c0a0700b003a5c1e916c8sm32949656wmp.1.2022.09.05.09.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 09:45:41 -0700 (PDT)
Date:   Mon, 5 Sep 2022 16:45:37 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: Fix double word in comments
Message-ID: <20220905164537.krwwsze5q252pxbi@liuwe-devbox-debian-v2>
References: <20220904154808.26022-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904154808.26022-1-dengshaomin@cdjrlc.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Sep 04, 2022 at 11:48:08AM -0400, Shaomin Deng wrote:
> Delete the rebundant word "in" in comments.
> 
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>

I changed the subject line a bit and pushed to hyperv-fixes.

Thanks,
Wei.
