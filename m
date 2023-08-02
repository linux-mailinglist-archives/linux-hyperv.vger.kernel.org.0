Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E336B76DB42
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Aug 2023 01:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjHBXK1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 19:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHBXK0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 19:10:26 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EBE1727;
        Wed,  2 Aug 2023 16:10:26 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-686ba97e4feso320711b3a.0;
        Wed, 02 Aug 2023 16:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691017825; x=1691622625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5J1Jr2A+AmEVJ3YQaMd97ioATpANcvZMYjjl7OLHuI=;
        b=igDt8av7q9/TvtrAqeDAp0L2mCus9QHlRFsbYHHU+sP4RaBQhtcxhuQ5kRTK1xVATP
         nDYzcw7l3RPd6sKyd3Xg/TIZRi5JXP3dkDC7Y0USbeY7I5OLBtIXJ4ohQJW+yoo8ypaq
         yxsNIQxx5qw3Hm121FScz9BcVZP4gOgEtA1FRceKQvT0ZmnpVG/tkt5OgX1FOb4k0hSd
         ZmQfuXU7nHG5CQpA1W5ahWoEmXMIGI1Cni/GQMegQKBOcKtyq5Kz5YQ/qWwrICmkaGQY
         fbfNiLT+iHwcjQh8mM4st/jL8A5W6WUWFEEmM0WGUdZTEoclXgWg4EaTWDityR2jKxe3
         0+uA==
X-Gm-Message-State: ABy/qLbSihRQCaNo8nLsS1WUQ+7DUd2u3AVK3xNP2wTc1u4TDsUvHg8v
        CgrglWKwkOfZUx5jdmi7UFM=
X-Google-Smtp-Source: APBJJlHFROEuKw8A9slDlgdQWEWfiiTvqmon2ZRST9cuflAhaS1fTIhO0K67Q6oBF+lcAyyTKX4KIQ==
X-Received: by 2002:a05:6a20:548c:b0:138:1980:1837 with SMTP id i12-20020a056a20548c00b0013819801837mr22535642pzk.13.1691017825606;
        Wed, 02 Aug 2023 16:10:25 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id u19-20020aa78493000000b00666e649ca46sm11519994pfn.101.2023.08.02.16.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 16:10:25 -0700 (PDT)
Date:   Wed, 2 Aug 2023 23:10:19 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, hpa@zytor.com
Subject: Re: [PATCH v3] x86/hyperv: add noop functions to x86_init mpparse
 functions
Message-ID: <ZMriW7IWemouYB43@liuwe-devbox-debian-v2>
References: <1687537688-5397-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687537688-5397-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 23, 2023 at 09:28:08AM -0700, Saurabh Sengar wrote:
> Hyper-V can run VMs at different privilege "levels" known as Virtual
> Trust Levels (VTL). Sometimes, it chooses to run two different VMs
> at different levels but they share some of their address space. In
> such setups VTL2 (higher level VM) has visibility of all of the
> VTL0 (level 0) memory space.
> 
> When the CONFIG_X86_MPPARSE is enabled for VTL2, the VTL2 kernel
> performs a search within the low memory to locate MP tables. However,
> in systems where VTL0 manages the low memory and may contain valid
> tables, this scanning can result in incorrect MP table information
> being provided to the VTL2 kernel, mistakenly considering VTL0's MP
> table as its own
> 
> Add noop functions to avoid MP parse scan by VTL2.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Applied to hyperv-fixes. Thanks.
