Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ADE616359
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 14:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiKBNGb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 09:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKBNGa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 09:06:30 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A8BBCAE;
        Wed,  2 Nov 2022 06:06:30 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id t4so10624293wmj.5;
        Wed, 02 Nov 2022 06:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZOR+AsyvMFr6m+rsPfEb64MpZyMWXOK2GQIuhfnojY=;
        b=kbzzTs97BRxBvcIpkj5jrSqQeRIqYGUQ67ee/UUt0F7PRs28QlTWJ60Wmw+FFxSFvg
         cXlRV+lLhex0SnYm7Vb68Z2/QTTHMNXJLJ9CRIyx8QooiNVlowwlT/cnvTtSm6ZTQr8R
         DRJuecOzuWsi5ntVOEUNOGXOrWqzbmyCDgkXV6sIZYVb9PbVqqNlDtQEbaffGXImcRRQ
         WtEeYq8lpOfadq5R/M0oA0bl+Ny2j0id35vtRoddmzrjMKYkdpFtaGYN3RTU2Y1R84E1
         5WkJgBG0u8g1c6TtnQqs9W3/rioSiVCofw+a8mGHOnA8ehG4bcoGFWdu68FMx7E2jg0c
         HndA==
X-Gm-Message-State: ACrzQf2gJJrdh6Unmu0+Z7MpIHzYJqE0HEnR3ixT7wulfG4107JPgLiT
        Usp5wC7AVNTVmnVpEe2vCv4=
X-Google-Smtp-Source: AMsMyM5fZ8uol08GARA634SedyOiScuLmBmhhesa8Bb43rYCLOmJKXIm/4DfWOp74+9DUuVtNkar5g==
X-Received: by 2002:a05:600c:42c9:b0:3cf:69d4:72d9 with SMTP id j9-20020a05600c42c900b003cf69d472d9mr13375572wme.93.1667394388589;
        Wed, 02 Nov 2022 06:06:28 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o40-20020a05600c512800b003cf54b77bfesm2066989wms.28.2022.11.02.06.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 06:06:27 -0700 (PDT)
Date:   Wed, 2 Nov 2022 13:06:21 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     decui@microsoft.com, quic_carlv@quicinc.com, wei.liu@kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        lpieralisi@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        robh@kernel.org, kw@linux.com, helgaas@kernel.org,
        alex.williamson@redhat.com, boqun.feng@gmail.com,
        Boqun.Feng@microsoft.com
Subject: Re: [PATCH v2] PCI: hv: Fix the definition of vector in
 hv_compose_msi_msg()
Message-ID: <Y2JrTWk+bVuYF3Af@liuwe-devbox-debian-v2>
References: <20221027205256.17678-1-decui@microsoft.com>
 <4dafab73-9957-f1df-69fe-3cfa59fb22fb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dafab73-9957-f1df-69fe-3cfa59fb22fb@quicinc.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Oct 28, 2022 at 08:08:03AM -0600, Jeffrey Hugo wrote:
> On 10/27/2022 2:52 PM, Dexuan Cui wrote:
> > The local variable 'vector' must be u32 rather than u8: see the
> > struct hv_msi_desc3.
> > 
> > 'vector_count' should be u16 rather than u8: see struct hv_msi_desc,
> > hv_msi_desc2 and hv_msi_desc3.
> > 
> > Fixes: a2bad844a67b ("PCI: hv: Fix interrupt mapping for multi-MSI")
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > Cc: Carl Vanderlip <quic_carlv@quicinc.com>
> 
> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Applied to hyperv-fixes. Thanks.
