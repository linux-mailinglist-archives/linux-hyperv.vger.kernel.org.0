Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF80B543058
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jun 2022 14:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbiFHM2j (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Jun 2022 08:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbiFHM2i (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Jun 2022 08:28:38 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA1F1AD583;
        Wed,  8 Jun 2022 05:28:35 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id d14so19164037wra.10;
        Wed, 08 Jun 2022 05:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xAmnRJ7onCqz/NfiJfHXfehZg2FcRlICmca8tphz6PQ=;
        b=yZNCxutMOqQFCtoKM53fKAeSfgx1b+icr3CoMeMemtwdDCz8EEKkzu7rEwNQNJC4DN
         pFDObeNBKTqU70i+vzylgchxMIYTaeMco2tGkcQzYJhYOeBzLlJLOOeNHrzXvPfBEYPg
         fvpR1/yo6cW7FGd5GuXI4Ar4hlRo+JvQPZK7wYxnH1jy8gDnWsabLifkoIb7NtphCKIU
         Gjltrf+9gAPSj5JkbnxbUyyLXpY4dvmlhcwL2JDDCpuzGvv2fP6HiDv7QDAzyiIh1jcN
         9zH2zF75GVPPgLHRaPodnBrTuDuGxudcgAhQkT2m1CDhm12nkThhgIwKPbuET28MI/OV
         R6+Q==
X-Gm-Message-State: AOAM533D6RIRgvPGzQfAFsjRErh0T6s70LalpW+Emwmnzx/PNdrTkCA5
        LNZKGpWi94w5mzBFWh8sT5w=
X-Google-Smtp-Source: ABdhPJyMftNVj/iSs0VPlx3V+0ZBhYtGWQKT8DoiKJZ7jHclv6c2zS3zElFGfxtKHsK0fLA1VUdDNA==
X-Received: by 2002:a5d:58ed:0:b0:217:dd5:7508 with SMTP id f13-20020a5d58ed000000b002170dd57508mr20119509wrd.606.1654691314007;
        Wed, 08 Jun 2022 05:28:34 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d58cc000000b0020c6b78eb5asm21447656wrf.68.2022.06.08.05.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 05:28:33 -0700 (PDT)
Date:   Wed, 8 Jun 2022 12:28:31 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, haiyangz@microsoft.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: hyperv: Correctly access fields declared as
 __le16
Message-ID: <20220608122831.e3yxjl2qlyumnm2j@liuwe-devbox-debian-v2>
References: <1654660177-115463-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654660177-115463-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 07, 2022 at 08:49:37PM -0700, Michael Kelley wrote:
> Add the use of le16_to_cpu() for fields declared as __le16. Because
> Hyper-V only runs in Little Endian mode, there's no actual bug.
> The change is made in the interest of general correctness in
> addition to making sparse happy. No functional change.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-fixes. Thanks.
