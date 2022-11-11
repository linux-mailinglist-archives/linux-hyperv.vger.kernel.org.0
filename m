Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC956265B2
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Nov 2022 00:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiKKXps (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Nov 2022 18:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbiKKXpr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Nov 2022 18:45:47 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA726EB56;
        Fri, 11 Nov 2022 15:45:46 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id v1so8222502wrt.11;
        Fri, 11 Nov 2022 15:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdGrmUFUT5Rd8rZ+Zxl1YHcsVYosGqPDTEcSuiV5How=;
        b=qj+YrvDnBW44gHFL3A79plbCMSDpyuXJCDYXj2VV8sxVG+HJ86uJZlgKv6LhNIO1T1
         Ptwtn/vmKGiuYjodLXaUW0pGVY4bIFS+5SL0ILijMB1GlOZPvw6kFlE7TaSmAneYDB31
         vcGSsq7F0ypcMK2p3naxeL8rQ1TvJlNsMKe0fI2BZ2G0W2xICtHhtwyR3nMyAme2AQ3H
         TKBDgCrY3U7xxn65bMUtWSpjwnyv0ZG92JE0eiiqKAL/sVniZXESJGUDuUEVIEvC2g5d
         3LQOpuYAiv5ez+S9GrQ+qaNkbUQ94kUGuEHKa75xQgpdx7bqD0+/q8VxT5QCWNI1a8AS
         NWCw==
X-Gm-Message-State: ANoB5pmZ5pj49rtyQX/+hdknHzoLIwNg4FQfe+XD+NcVk5um4BQqihLN
        C4GceExVxDsAK3SQ8l6G2uA=
X-Google-Smtp-Source: AA0mqf6lGQZ2lPyFsU2t2mEch5X8o1SlRhubcrsSs0D8K0tPgSNqMyKM1rm4AoWr/Js40PHc2BZprQ==
X-Received: by 2002:adf:ba52:0:b0:236:55a7:cf2 with SMTP id t18-20020adfba52000000b0023655a70cf2mr2511721wrg.270.1668210344834;
        Fri, 11 Nov 2022 15:45:44 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n13-20020adff08d000000b002364c77bcacsm2909606wro.38.2022.11.11.15.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:45:44 -0800 (PST)
Date:   Fri, 11 Nov 2022 23:45:42 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/1] scsi: storvsc: Fix handling of srb_status and
 capacity change events
Message-ID: <Y27epsxr/NAw86QQ@liuwe-devbox-debian-v2>
References: <1668019722-1983-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668019722-1983-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Nov 09, 2022 at 10:48:42AM -0800, Michael Kelley wrote:
> Current handling of the srb_status is incorrect. Commit 52e1b3b3daa9
> ("scsi: storvsc: Correctly handle multiple flags in srb_status")
> is based on srb_status being a set of flags, when in fact only the
> 2 high order bits are flags and the remaining 6 bits are an integer
> status. Because the integer values of interest mostly look like flags,
> the code actually works when treated that way.
> 
> But in the interest of correctness going forward, fix this by treating
> the low 6 bits of srb_status as an integer status code. Add handling
> for SRB_STATUS_INVALID_REQUEST, which was the original intent of commit
> 52e1b3b3daa9. Furthermore, treat the ERROR, ABORTED, and INVALID_REQUEST
> srb status codes as essentially equivalent for the cases we care about.
> There's no harm in doing so, and it isn't always clear which status code
> current or older versions of Hyper-V report for particular conditions.
> 
> Treating the srb status codes as equivalent has the additional benefit
> of ensuring that capacity change events result in an immediate rescan
> so that the new size is known to Linux. Existing code checks SCSI
> sense data for capacity change events when the srb status is ABORTED.
> But capacity change events are also being observed when Hyper-V reports
> the srb status as ERROR. Without the immediate rescan, the new size
> isn't known until something else causes a rescan (such as running
> fdisk to expand a partition), and in the meantime, tools such as "lsblk"
> continue to report the old size.
> 
> Fixes: 52e1b3b3daa9 ("scsi: storvsc: Correctly handle multiple flags in srb_status")
> Reported-by: Juan Tian <juantian@microsoft.com>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-fixes. Thanks.
