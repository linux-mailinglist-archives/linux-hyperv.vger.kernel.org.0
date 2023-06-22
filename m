Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB4573A7F9
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jun 2023 20:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjFVSMH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jun 2023 14:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFVSMG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jun 2023 14:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B821BF6;
        Thu, 22 Jun 2023 11:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F08E618CF;
        Thu, 22 Jun 2023 18:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56859C433C0;
        Thu, 22 Jun 2023 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687457524;
        bh=sbgN011gcBN7s2BCAlLe1ljxtv7/CztCExKzSZ2O7j4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5o1PUNASBKoAIeJ1NYb0kD6UC4BmgTam/VUlDTb9tYzKIk+gGwYKL1R59n7TVXEm
         kyQeX6DmUfyXZlhAFRAklTgI7w+UMtdpG51gsgVQiVBPw2vSzZQPD88Jo0J1Nag+38
         8NMslLP/MHw5MIR6Emn8fsot/4bDiPNRUkZoT81s=
Date:   Thu, 22 Jun 2023 20:12:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurabh Singh Sengar <ssengar@microsoft.com>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v2 2/5] tools: hv: Add vmbus_bufring
Message-ID: <2023062243-dazzling-patio-3ef9@gregkh>
References: <1686766512-2589-1-git-send-email-ssengar@linux.microsoft.com>
 <1686766512-2589-3-git-send-email-ssengar@linux.microsoft.com>
 <2023061430-facedown-getting-d9f7@gregkh>
 <PUZP153MB07492FF43240CFD055CF268ABE5CA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
 <2023062020-swung-sensitive-4866@gregkh>
 <SEZP153MB0742B43EC4E490E2FEACDA4ABE22A@SEZP153MB0742.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZP153MB0742B43EC4E490E2FEACDA4ABE22A@SEZP153MB0742.APCP153.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jun 22, 2023 at 05:47:58PM +0000, Saurabh Singh Sengar wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, June 20, 2023 12:36 PM
> > To: Saurabh Singh Sengar <ssengar@microsoft.com>
> > Cc: Saurabh Sengar <ssengar@linux.microsoft.com>; KY Srinivasan
> > <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> > wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>; Michael Kelley
> > (LINUX) <mikelley@microsoft.com>; corbet@lwn.net; linux-
> > kernel@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-
> > doc@vger.kernel.org
> > Subject: Re: [EXTERNAL] Re: [PATCH v2 2/5] tools: hv: Add vmbus_bufring
> > 
> > On Tue, Jun 20, 2023 at 05:25:06AM +0000, Saurabh Singh Sengar wrote:
> > > > > diff --git a/tools/hv/vmbus_bufring.c b/tools/hv/vmbus_bufring.c
> > > > > new file mode 100644 index 000000000000..d44a06d45b03
> > > > > --- /dev/null
> > > > > +++ b/tools/hv/vmbus_bufring.c
> > > > > @@ -0,0 +1,322 @@
> > > > > +// SPDX-License-Identifier: BSD-3-Clause
> > > > > +/*
> > > > > + * Copyright (c) 2009-2012,2016,2023 Microsoft Corp.
> > > > > + * Copyright (c) 2012 NetApp Inc.
> > > > > + * Copyright (c) 2012 Citrix Inc.
> > > > > + * All rights reserved.
> > > >
> > > > No copyright for the work you did?
> > >
> > > I have added 2023 Microsoft Corp. Please let me know if I need to add
> > > anything more.
> > 
> > Please contact your lawyers about EXACTLY what you need to do here, that's
> > up to them, not me!
> 
> I have cross verified this with our legal team and they are fine with it.

Wonderful, please have them sign-off on the patch as well when you
resubmit it.

thanks,

greg k-h
