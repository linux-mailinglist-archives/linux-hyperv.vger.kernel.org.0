Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2429B6E03B6
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Apr 2023 03:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjDMBbt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Apr 2023 21:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDMBbs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Apr 2023 21:31:48 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D5F121;
        Wed, 12 Apr 2023 18:31:47 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso3087770wmo.0;
        Wed, 12 Apr 2023 18:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681349506; x=1683941506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9C3dFAu0hHRvj63wKtnrnN7r4TEMw3YR/cX0XFbBe8=;
        b=G1opHY/Zr2mLyB2//lKeD5cfxBvs5T2YZZvg/YNzJXUbMoNahllnQnISWoCTovuIki
         UFPdUiCh1L6y2OaUsqDbkEusdZ8H49bFIhSQscBUDSKepRy8G5F7aBR6Xle+nDFPFJvT
         Q4XnTWqUkv/Gw0rH+LGSK8DtQ7nUxNS6uIJX66i6hH9WMhjPIQXSzKo02+T60ywwzTR6
         cE95LYHeuJsMBGSqTGqlhKYRfOz9OzVRBqE1Sd9XPdftgGtoYBvhNkkQz9knzB7CPaDS
         njLGdArK80a7k5cXYErSBAVEzJqlFqD618+EnyH5zZjtxgCbMQQxFBNdCMvCsEbRhqVB
         fg3A==
X-Gm-Message-State: AAQBX9dPbMX3aA7FxYY5W8TTefFQzHzrgZPDJREWEogfTwuQTG2dkR2Z
        svN0P5jXsq8Knse2TnCbByE=
X-Google-Smtp-Source: AKy350ZTK1d4GtjHyWoGBp6+LxTkqIK0OBzZWtNl7cM87hOiZqyRzyhX5yVr4lP4SGPEnDYJUZUzWA==
X-Received: by 2002:a05:600c:2141:b0:3f0:9a3f:c8b5 with SMTP id v1-20020a05600c214100b003f09a3fc8b5mr453813wml.27.1681349506449;
        Wed, 12 Apr 2023 18:31:46 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s6-20020a7bc386000000b003ef5db16176sm419230wmj.32.2023.04.12.18.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 18:31:46 -0700 (PDT)
Date:   Thu, 13 Apr 2023 01:31:42 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>, decui@microsoft.com
Subject: Re: [PATCH] hv/hv_kvp_daemon: Add support for keyfile config based
 connection profile in NM
Message-ID: <ZDdbfiMD8iq2OH9s@liuwe-devbox-debian-v2>
References: <1677133334-6958-1-git-send-email-shradhagupta@linux.microsoft.com>
 <ZAYJhm9fVAgCtTiC@liuwe-devbox-debian-v2>
 <20230307052408.GA11548@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307052408.GA11548@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Shradha

On Mon, Mar 06, 2023 at 09:24:08PM -0800, Shradha Gupta wrote:
> On Mon, Mar 06, 2023 at 03:40:54PM +0000, Wei Liu wrote:
> > On Wed, Feb 22, 2023 at 10:22:14PM -0800, Shradha Gupta wrote:
> > > As communicated in BZ <2122115>, ifcfg config file support in
> > 
> > What is BZ <2122115>? I guess that's Red Hat's bugzilla?
> > 
> > I don't think this is useful information for the commit message, since
> > the community cannot access that ticket.
> Thanks for the pointer, will change this
> > 
> > > NetworkManger is deprecated. This patch provides support for the
> > > new keyfile config format for connection profiles in NetworkManager.
> > > The patch modifies the hv_kvp_daemon code to generate the new network
> > > configuration in keyfile format(.ini-style format) instead of ifcfg
> > > format.
> > 
> > Okay, so the wire protocol for the KVP daemon is not changed. It is just
> > the intermediate file format that's changed.
> > 
> That is correct.
> > > This configuration is stored in a temp file which is further translated
> > > using the hv_set_ifconfig.sh script. This script is implemented by
> > > individual distros based on the network management commands supported.
> > > For example, RHEL's implementation could be found here:
> > > https://gitlab.com/redhat/centos-stream/src/hyperv-daemons/-/blob/c9s/hv_set_ifconfig.sh
> > > Debian's implementation could be found here:
> > > https://github.com/endlessm/linux/blob/master/debian/cloud-tools/hv_set_ifconfig
> > > 
> > > The next part of this support is to inform the Distro vendors to
> > > modify these implementations to consume the new configuration format.
> > > 
> > 
> > I guess they will figure out the format has changed when they upgrade to
> > a new kernel?
> Yeah, so whenever they decide to use the latest kernel, they would have to change
> their implementation to consume these changes.

Can you resend with my comments addressed and ask member of the best
guest team to give an ack or review?

It does look sensible, but I guess I'm not in a good enough position to
determine the guest side tools changes.

Thanks,
Wei.


> > 
> > Thanks,
> > Wei.
