Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF0168E02C
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Feb 2023 19:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBGShr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Feb 2023 13:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjBGShk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Feb 2023 13:37:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96A5B4489;
        Tue,  7 Feb 2023 10:37:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9ACA1042;
        Tue,  7 Feb 2023 10:38:18 -0800 (PST)
Received: from bogus (unknown [10.57.10.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D44203F71E;
        Tue,  7 Feb 2023 10:37:32 -0800 (PST)
Date:   Tue, 7 Feb 2023 18:37:29 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        Sudeep Holla <sudeep.holla@arm.com>, ssengar@microsoft.com
Subject: Re: [PATCH v2 0/6] Device tree support for Hyper-V VMBus driver
Message-ID: <20230207183729.ytqbikaxnurs2iet@bogus>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqKL3JA6nAkEHuuyxbs8-Mm=Q-nNkCmpnDApNUDVbLsvKw@mail.gmail.com>
 <20230201020449.GC20379@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201020449.GC20379@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 31, 2023 at 06:04:49PM -0800, Saurabh Singh Sengar wrote:
>
> We are working on a solution where kernel is booted without ACPI tables to keep
> the overall system's memory footprints slim and possibly faster boot time.
> We have tested this by enabling CONFIG_OF for x86.
>

Very interesting. Do you comparison on how slow/fast DT version w.r.t
ACPI and similarly for the memory footprint ? It would be good to add
those information as well. I know some systems just use ACPI static tables
as they don't run ACPICA runtime interpretter, was that experimented as
well or it wasn't used due to some specific(details please) limitations
without it.

> I can add this info in cover letter in next version.

Yes please.

-- 
Regards,
Sudeep
