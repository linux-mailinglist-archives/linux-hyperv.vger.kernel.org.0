Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98371685F06
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Feb 2023 06:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjBAFgq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Feb 2023 00:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBAFgp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Feb 2023 00:36:45 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BC3B53E4E;
        Tue, 31 Jan 2023 21:36:44 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id D018020B7102; Tue, 31 Jan 2023 21:36:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D018020B7102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675229803;
        bh=a+n6LU8y9WW4464PUW7kstwyrtfB8Fsw1PFizOcqRRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/6RMiOaTDNj3OQ1aTHk1FbVvURNNJqZPCIB0Lx/33doooI6f5MYGA48YvR0eWXUL
         KNUQ512M78xE8Jsg07VVLcCfYnClH3QCa4UonAfixtb3j+COBhJlW25VERq3EzwXCD
         HEgemei3lgcq2MuAy3QWwLaJQrsORJz7O687RfQo=
Date:   Tue, 31 Jan 2023 21:36:43 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Rob Herring <robh@kernel.org>
Cc:     tglx@linutronix.de, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wei.liu@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        virtualization@lists.linux-foundation.org, haiyangz@microsoft.com,
        decui@microsoft.com, daniel.lezcano@linaro.org,
        ssengar@microsoft.com
Subject: Re: [PATCH v2 4/6] dt-bindings: hypervisor: Rename virtio to
 hypervisor
Message-ID: <20230201053643.GA31571@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-5-git-send-email-ssengar@linux.microsoft.com>
 <167519443459.1836211.1945655170442861713.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167519443459.1836211.1945655170442861713.robh@kernel.org>
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

On Tue, Jan 31, 2023 at 01:57:36PM -0600, Rob Herring wrote:
> 
> On Tue, 31 Jan 2023 10:10:07 -0800, Saurabh Sengar wrote:
> > Rename virtio folder to more generic hypervisor, so that this can
> > accommodate more devices of similar type.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  .../devicetree/bindings/{virtio => hypervisor}/mmio.yaml        | 2 +-
> >  .../devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml   | 2 +-
> >  .../bindings/{virtio => hypervisor}/virtio-device.yaml          | 2 +-
> >  MAINTAINERS                                                     | 2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> >  rename Documentation/devicetree/bindings/{virtio => hypervisor}/mmio.yaml (95%)
> >  rename Documentation/devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml (98%)
> >  rename Documentation/devicetree/bindings/{virtio => hypervisor}/virtio-device.yaml (93%)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/i2c/i2c-virtio.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/virtio/virtio-device.yaml
> ./Documentation/devicetree/bindings/gpio/gpio-virtio.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/virtio/virtio-device.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-virtio.example.dtb: i2c: False schema does not allow {'compatible': ['virtio,device22'], '#address-cells': [[1]], '#size-cells': [[0]], 'light-sensor@20': {'compatible': ['dynaimage,al3320a'], 'reg': [[32]]}, '$nodename': ['i2c']}
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/gpio-virtio.example.dtb: gpio: False schema does not allow {'compatible': ['virtio,device29'], 'gpio-controller': True, '#gpio-cells': [[2]], 'interrupt-controller': True, '#interrupt-cells': [[2]], '$nodename': ['gpio']}
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hypervisor/virtio-device.example.dtb: i2c: False schema does not allow {'compatible': ['virtio,device22'], '$nodename': ['i2c']}
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
> 
> doc reference errors (make refcheckdocs):
> MAINTAINERS: Documentation/devicetree/bindings/virtio/
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1675188609-20913-5-git-send-email-ssengar@linux.microsoft.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.

Hi Rob,

I set DT_SCHEMA_FILES as below and ran "make -j32 DT_CHECKER_FLAGS=-m dt_binding_check".
export DT_SCHEMA_FILES=Documentation/devicetree/bindings/hypervisor

But I can see only below error:
/work/upstream/linux-next/Documentation/devicetree/bindings/hypervisor/virtio-device.example.dtb: i2c: False schema does not allow {'compatible': ['virtio,device22'], '$nodename': ['i2c']}
        From schema: /work/upstream/linux-next/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml

If I unset DT_SCHEMA_FILES, I see lot many errors which are not related to my changes.
May I know what can I do to simulate the exact behaviour of your bot.

Version of all the packages look latest:

$ pip3 show dtschema
Name: dtschema
Version: 2023.1
Summary: DeviceTree validation schema and tools
Home-page: https://github.com/devicetree-org/dt-schema
Author: Rob Herring
Author-email: robh@kernel.org
License: BSD
Location: /home/azureuser/.local/lib/python3.8/site-packages
Requires: rfc3987, jsonschema, pylibfdt, ruamel.yaml
Required-by:


$ dt-doc-validate --version
2023.1


$ yamllint --version
yamllint 1.20.0


Regards,
Saurabh

