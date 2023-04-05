Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8806D8AF3
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Apr 2023 01:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjDEXK1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Apr 2023 19:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDEXKX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Apr 2023 19:10:23 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7527689;
        Wed,  5 Apr 2023 16:10:22 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id p34so21726882wms.3;
        Wed, 05 Apr 2023 16:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680736220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH0b9keGrNu1LRP9YRlY29aoS1L8tBZoylAnz1gu7cU=;
        b=okc5MsXVrWVeE0j8LCIfUUtPHwDuAFw9EQNMV9F4PS1/bJCK0wYv1xhUMw8Unpngro
         TGBwRkZXVu9sZZEhNRIqk8rm0gRW5kj/oR0gg60LlWEPLwMIue9d0+N9FT8V03+Dq860
         6WCUU7i4fSuhiBg5XgdMC4SvDapMRnDPTrrMOecysZ5j2QSozut3lqVSREBQpZcBcJCa
         x7g4QPZ2AQV5KufhjlI70ZBOhyj6bkS3PwuRxFQPa6nl481GAqA72A8wu8k4qtQsmuVl
         Npftpn6XzVa5vAixrBKqb1LOusZ3ZTNKxGC1bPsL9T+zUIMgzXBcyrr/x+VjcRfBNdcL
         +eUw==
X-Gm-Message-State: AAQBX9fptUsFSYvgQCrjo3yxa75DkqkvAmeSEH7STXro68O2Sjv+tRw3
        24lGcAp8kwploQntVscFZFs=
X-Google-Smtp-Source: AKy350aPrYpCwOaoawaUzKvLRCEaZ7mlpZY/R8hPpjz7oH8P1rbfELDCftnMZUJXp6IasY2L5cjr8w==
X-Received: by 2002:a7b:cbd2:0:b0:3f0:5519:9049 with SMTP id n18-20020a7bcbd2000000b003f055199049mr6310683wmi.8.1680736220368;
        Wed, 05 Apr 2023 16:10:20 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x1-20020adfec01000000b002e52dfb9256sm2701wrn.41.2023.04.05.16.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 16:10:19 -0700 (PDT)
Date:   Wed, 5 Apr 2023 23:10:17 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH v9 4/5] dt-bindings: bus: VMBus
Message-ID: <ZC3/2Xf+L3rer9ds@liuwe-devbox-debian-v2>
References: <1679298460-11855-1-git-send-email-ssengar@linux.microsoft.com>
 <1679298460-11855-5-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679298460-11855-5-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Mar 20, 2023 at 12:47:39AM -0700, Saurabh Sengar wrote:
> Add dt-bindings for Hyper-V VMBus.

Do you perhaps want to use this as the commit subject line? The original
one looks to be cut off half way.

I can change this patch on my end. Just let me know.

Thanks,
Wei.
