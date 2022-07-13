Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CA7573D8D
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Jul 2022 22:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbiGMUGK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 13 Jul 2022 16:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiGMUGK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 13 Jul 2022 16:06:10 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9FA21E3F;
        Wed, 13 Jul 2022 13:06:09 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 337E02B2;
        Wed, 13 Jul 2022 20:06:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 337E02B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1657742769; bh=f+396u8AhP4c63PIsOuUAfTJE40+bYRHpfyCrl1NdoA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sBewgn4VfGSSd+JyKOCv5KTcABGHRZUrFxzNQb4xMRP4V03mWEPP7m0GdaEWbEnfd
         1KUdCRVShONAXjxuJwxFuQpLJUStRKzfaLadrVnpcyDBdxgRUAt3QsUkLQ3EE+n8e3
         F3CuO+xT5BN2VGQEdQo8P2KOedYYH3ar+dYz+LVP9Gv5T1Bfwl0ndfkx73uXGnr48t
         dqjPjxFzhIm0zJzOLxVDtI36qQseUFhVSTFizjwd+DipoLkXdS1DMfyRG27kkOYYbA
         yDBGKsNV0bRud9yN6cpjKCFofvP6V7xfSPtKahmGsiXNZ1OSEDrVvEBwhV/cJoD4EU
         OqVZ0tVyvAtcQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Documentation: hyperv: Add basic info on Hyper-V
 enlightenments
In-Reply-To: <20220711185640.px4bwf4ldqqqw5ij@liuwe-devbox-debian-v2>
References: <1657561704-12631-1-git-send-email-mikelley@microsoft.com>
 <20220711185640.px4bwf4ldqqqw5ij@liuwe-devbox-debian-v2>
Date:   Wed, 13 Jul 2022 14:06:08 -0600
Message-ID: <8735f44w27.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> On Mon, Jul 11, 2022 at 10:48:21AM -0700, Michael Kelley wrote:
>> This documentation is a high level overview to explain the basics
>> of Linux running as a guest on Hyper-V. The intent is to document
>> the forest, not the trees. The Hyper-V Top Level Functional Spec
>> provides conceptual material and API details for the core Hyper-V
>> hypervisor, and this documentation provides additional info on
>> how that functionality is applied to Linux. Also, there's no
>> public documentation on VMbus or the VMbus synthetic devices, so
>> this documentation helps fill that gap at a conceptual level. This
>> documentation is not API-level documentation, which can be seen
>> in the code and associated comments.
>> 
>> More topics will be added in future patches, including:
>> 
>> * Miscellaneous synthetic devices like KVP, timesync, VSS, etc.
>> * Virtual PCI support
>> * Isolated/Confidential VMs
>> * UIO driver
>> 
>> If you think I'm missing a topic that fits into the overall
>> approach as described, feel free to suggest text, or let me
>> know and I can add it to my list.
>> 
>> Changes in v2:
>> * Updated clocks.rst to use section hierarchy that matches
>>   overview.rst and vmbus.rst [Wei Liu]
>> 
>> Michael Kelley (3):
>>   Documentation: hyperv: Add overview of Hyper-V enlightenments
>>   Documentation: hyperv: Add overview of VMbus
>>   Documentation: hyperv: Add overview of clocks and timers
>
> Content-wise all patches look good to me.
>
> Jonathan, let me know how you would like to handle this series. I'm
> happy to carry them in hyperv-next.

I went ahead and applied them while I was in the neighborhood.

Thanks,

jon
