Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA3D68E64F
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Feb 2023 03:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjBHCvw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Feb 2023 21:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjBHCvv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Feb 2023 21:51:51 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25B18E3B0;
        Tue,  7 Feb 2023 18:51:50 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 7A8C420C7E3E; Tue,  7 Feb 2023 18:51:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A8C420C7E3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675824709;
        bh=/8sypdsBFJ9BayyXPQW3tsqVwQ5HKWArPlSI9nkM8R4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+vpjfvj+umQjEGJfek92nTkeB45CtCxc+Z3ILKuBI7JjSXK9DWTc67imS/3UTG8y
         WLGgMSURm2yLoqYte2jWNPq11PDNG5fCoEeEGZ6wsKeO8shYivV6MXx6NDgSa/YjeL
         hYYMw2eF4mykznZGLZlCtoHhJtDlRDxZ4X3QAMAw=
Date:   Tue, 7 Feb 2023 18:51:49 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com, dphadke@linux.microsoft.com
Subject: Re: [PATCH v4 4/6] dt-bindings: hypervisor: Rename virtio to
 hypervisor
Message-ID: <20230208025149.GC838@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1675756199-5917-1-git-send-email-ssengar@linux.microsoft.com>
 <1675756199-5917-5-git-send-email-ssengar@linux.microsoft.com>
 <20230207183931.GB3753062-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207183931.GB3753062-robh@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Feb 07, 2023 at 12:39:31PM -0600, Rob Herring wrote:
> On Mon, Feb 06, 2023 at 11:49:57PM -0800, Saurabh Sengar wrote:
> > Rename virtio folder to more generic hypervisor, so that this can
> > accommodate more devices of similar type.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  Documentation/devicetree/bindings/gpio/gpio-virtio.yaml               | 4 ++--
> >  Documentation/devicetree/bindings/{virtio => hypervisor}/mmio.yaml    | 2 +-
> >  .../devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml         | 2 +-
> >  .../devicetree/bindings/{virtio => hypervisor}/virtio-device.yaml     | 2 +-
> >  Documentation/devicetree/bindings/i2c/i2c-virtio.yaml                 | 4 ++--
> >  MAINTAINERS                                                           | 2 +-
> >  6 files changed, 8 insertions(+), 8 deletions(-)
> >  rename Documentation/devicetree/bindings/{virtio => hypervisor}/mmio.yaml (95%)
> >  rename Documentation/devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml (98%)
> >  rename Documentation/devicetree/bindings/{virtio => hypervisor}/virtio-device.yaml (93%)
> 
> virtio is used for more than just an interface to hypervisors. I think 
> this should remain. Instead, I'd put vmbus under bindings/bus/.

Agree, will move to bus in v5

> 
> Rob
