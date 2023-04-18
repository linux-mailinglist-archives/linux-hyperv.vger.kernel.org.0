Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5946E6AF3
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Apr 2023 19:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjDRR2V (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Apr 2023 13:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjDRR2K (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Apr 2023 13:28:10 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D6912CA4;
        Tue, 18 Apr 2023 10:28:00 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id o9-20020a05600c510900b003f17012276fso227073wms.4;
        Tue, 18 Apr 2023 10:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681838879; x=1684430879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRECZfpPqwPiFqXZsYKWy9wzR6uKQSi1jtPmNy/y+as=;
        b=GuenAZp7LRkBr4U50R9u9Z8WABcromYOwPO1TqeX6vNhciShbiQQFITnV7sOCiTrfs
         +IKc29++CXAfwsGbX0PfocuuHLD2HJdiuHjAW/cvmlGsTYaO9Po9wr/2knUqrJROGWEQ
         FBrLg6HTX7zydgkqpt0mB63z+FzmEvIs/4di3DiyvqIZQpKdC84X/yobOzENvE0PMxHa
         jmHXA9P979L2qOLrDsBfG2bn7ge0X5J8rWSfqMAwKz9jECcRcn8VBuiWFiT+B7rWt+/f
         AOtVRFZGrOSsTjgashVMN+oznSYY3DYTgwByZuI4o56WYHLVM0y2JliNpKd//OuMLwWl
         w2Cg==
X-Gm-Message-State: AAQBX9eTmRd2x0QUpHQPBtz8+BwSG5sy/ZvBZO/W8Qi17GDJeXRHS+ru
        jSmL+MGzMkw1SPV8NjocQvk=
X-Google-Smtp-Source: AKy350bEDjKbUiINLa2fyZpH36zA04Bb+S5PQHmjA4He/MPiZ4PNwDCMULq70l46rS/ibzGtJ+uJOA==
X-Received: by 2002:a1c:7410:0:b0:3ef:df3:1693 with SMTP id p16-20020a1c7410000000b003ef0df31693mr14527011wmc.32.1681838879217;
        Tue, 18 Apr 2023 10:27:59 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d66ce000000b002f103ca90cdsm13660440wrw.101.2023.04.18.10.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 10:27:58 -0700 (PDT)
Date:   Tue, 18 Apr 2023 17:27:55 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix for applied series [PATCH v5 0/5] Hyper-V VTL
 support
Message-ID: <ZD7TGzJg1tSYt3jL@liuwe-devbox-debian-v2>
References: <1681794761-13734-1-git-send-email-ssengar@linux.microsoft.com>
 <20230418093321.GAZD5j4SZ7QWmUyAXW@fat_crate.local>
 <ZD7CllwJv7aAB4vO@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD7CllwJv7aAB4vO@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 18, 2023 at 04:17:26PM +0000, Wei Liu wrote:
> On Tue, Apr 18, 2023 at 11:33:21AM +0200, Borislav Petkov wrote:
> > On Mon, Apr 17, 2023 at 10:12:39PM -0700, Saurabh Sengar wrote:
> > > [PATCH v5 0/5] Hyper-V VTL support is already applied, however
> > > there are couple of kernel test bot warning reported. This patch
> > > series on top of [PATCH v5 0/5] Hyper-V VTL support fixes these.
> > > I expect them to be squash commit on respective patches.
> > 
> > That was supposed to happen when applying those using -rc7 as a base.
> > 
> > Wei, what's up?
> 
> I did use -rc7 as the base. This is what is in hyperv-next right now.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?h=hyperv-next&id=25dcc7316ef7def25cdab3658ac665bf0ce0ddc5
> 
> I think Saurabh was responding to a report that was generated on his v5
> series. I don't think the first patch is needed.

Never mind, I think I messed up when applying Saurabh's patch. I will
fix the tree today.

Thanks,
Wei.
