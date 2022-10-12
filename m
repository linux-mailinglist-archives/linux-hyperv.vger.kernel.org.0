Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE7D5FC8B0
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Oct 2022 17:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJLPv2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Oct 2022 11:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiJLPv1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Oct 2022 11:51:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CF4F193F;
        Wed, 12 Oct 2022 08:51:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 796C8B819D9;
        Wed, 12 Oct 2022 15:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABB3C433C1;
        Wed, 12 Oct 2022 15:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665589881;
        bh=uWgi3jGpfAFbQQu88mP0kZwhxtsWDEB1EyOYRYv+tIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZENHhBBQ+qwxnIV17n6kdhRJJq+t2kbQmhgCbNn+nTTG7+nyLhfILzKFlDlcEZxTT
         diUP/98z34qsvDPGymLCRrPJ4l8pcrxD2PsqSmYdtixMO8UHLyVWY9hv/CFX3lBKeG
         sPBD+Gp5Si/aAFcamr1BH3J2UnqGKPJhpyKG33D4=
Date:   Wed, 12 Oct 2022 17:52:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH] uio_hv_generic: Enable support for slower vmbus device
 channels
Message-ID: <Y0bipdisMbTNMYOq@kroah.com>
References: <1665575806-27990-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1665575806-27990-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 12, 2022 at 04:56:46AM -0700, Saurabh Sengar wrote:
> This patch enables support for slower vmbus channels, which consist
> of following 3 changes :
> 	1. Support for hypercalls
> 	2. Module params for recv/send buffer sizes
> 	3. Module param for custom ring buffer sizes

Even if this all was ok, you are doing 3 things all in one change,
that's not allowed at all, you all know this.

Anyway, no new module parameters, this is not the 1990's, we have much
better ways to do this properly (hint, module parameters modify code,
you want to modify the options of a specific device.)

greg k-h
