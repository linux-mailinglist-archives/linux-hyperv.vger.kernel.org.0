Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75B86DA390
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Apr 2023 22:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240067AbjDFUlP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Apr 2023 16:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbjDFUkv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Apr 2023 16:40:51 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DBFD50D;
        Thu,  6 Apr 2023 13:36:50 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id r11so40700665wrr.12;
        Thu, 06 Apr 2023 13:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813409; x=1683405409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86pSHJQu+AoGkaxYEVcfYHcMCnPQLhP4bpRlqk/CQPk=;
        b=esBU0mIeX3/U80A+Be/Xnlbgi+ZxM5LJig7psgaRHyVBG52bhOlb1PxS+Exw5DfIL/
         pweYrFhLGCuyI1F5LILpCH6WVjGhK0QJL9Vv4J2f3LSAmcFM16uG3Wj1B9xxq42oCLmg
         dA1pdi0v91qdjBkeA9cBKPcd7RYHXbWg4Pdv3Jhsqv0CuFVnrPms9o+cHGfdl/1DlVdK
         EznsLyS+h1Fyprer61qRqRkK3gArQpw5zuqHsnpalx7I1yGlyPug9I1LNPCLJVOs+Bi6
         fFi2piarUTojymWRNaj8NCYU29vv317Gn440YJrHXZkn6apc+SJQhML0/2ue5pNlDL+H
         Pd+w==
X-Gm-Message-State: AAQBX9fI9w+Yth0or9g6gJdghKrqosm/8vFrCrIo5cvPUxyYfE67fox/
        M8f47Rqjau1LKOyb/59691xFHIxObSivvg==
X-Google-Smtp-Source: AKy350b2PIP7mfUQgql8PR056N3jlcv//PoKLuKYmDBs1jORZLHQ/q1XL4oqpFw49Xgt2E27fNJEOQ==
X-Received: by 2002:a05:6000:100d:b0:2cf:ef9d:16a5 with SMTP id a13-20020a056000100d00b002cfef9d16a5mr8106752wrx.18.1680813408529;
        Thu, 06 Apr 2023 13:36:48 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id y8-20020adfe6c8000000b002c559843748sm2680167wrm.10.2023.04.06.13.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:36:47 -0700 (PDT)
Date:   Thu, 6 Apr 2023 20:36:44 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        mikelley@microsoft.com
Subject: Re: [PATCH v9 4/5] dt-bindings: bus: VMBus
Message-ID: <ZC8tXOjT+D4WR2vm@liuwe-devbox-debian-v2>
References: <1679298460-11855-1-git-send-email-ssengar@linux.microsoft.com>
 <1679298460-11855-5-git-send-email-ssengar@linux.microsoft.com>
 <ZC3/2Xf+L3rer9ds@liuwe-devbox-debian-v2>
 <20230406030316.GA9750@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406030316.GA9750@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 05, 2023 at 08:03:16PM -0700, Saurabh Singh Sengar wrote:
> On Wed, Apr 05, 2023 at 11:10:17PM +0000, Wei Liu wrote:
> > On Mon, Mar 20, 2023 at 12:47:39AM -0700, Saurabh Sengar wrote:
> > > Add dt-bindings for Hyper-V VMBus.
> > 
> > Do you perhaps want to use this as the commit subject line? The original
> > one looks to be cut off half way.
> 
> In the first version of this patch series, I had this as subject line, however
> 'dt-bindings' was repetetive in subject line hence asked to be dropped by
> device-tree maintainers.
> 
> Ref: https://lore.kernel.org/lkml/f74fe561-dc20-0681-12af-4a4782a060be@linaro.org/
> 
> If this subject line looks cut in half, may be we can modify it to:
> dt-bindings: bus: Add Hyper-V VMBus

Okay. Let change the title to this.

Thanks,
Wei.
