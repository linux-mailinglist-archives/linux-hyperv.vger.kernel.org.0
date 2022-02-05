Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205934AA510
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 01:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378595AbiBEAbS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 19:31:18 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59046 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352482AbiBEAbS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 19:31:18 -0500
Received: from [192.168.1.17] (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id E3C7820B6C61;
        Fri,  4 Feb 2022 16:31:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3C7820B6C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644021078;
        bh=hu1H4uGZ0JEPq7xzJcNDhKMllfxHPdflVQYUNHmN5wo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QPOBabXajrruzMbBRSBn/Kn7xuQkGiScEdYIXUdixSNT8M4v6Uv0EYbbCFchACF0l
         Pa3x31JZSYbVwBnNU/9xlpEYYchkDUw12IBBe350o6KMAAvZKGYAYZe2ijL4n6Z7/R
         IoviCnt47T4PdTGaVVLl6/ENfRBT7YeQ3qJLMr1Y=
Message-ID: <de6d6bd8-889f-45d6-b45e-7ed8cac3e54b@linux.microsoft.com>
Date:   Fri, 4 Feb 2022 16:31:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1 0/9] drivers: hv: dxgkrnl: Driver overview
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
References: <cover.1641937419.git.iourit@linux.microsoft.com>
 <Yd9SQxTznfHGjuDD@archlinux-ax161>
 <bd36b131-be23-6f4d-16cf-a549a6533f34@linux.microsoft.com>
 <YfCVi/TGD9Dnf9CG@dev-arch.archlinux-ax161>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <YfCVi/TGD9Dnf9CG@dev-arch.archlinux-ax161>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 1/25/2022 4:27 PM, Nathan Chancellor wrote:
> Hi Iouri,
>
> On Wed, Jan 12, 2022 at 03:39:13PM -0800, Iouri Tarassov wrote:
> > 
> drivers/hv/dxgkrnl/dxgvmbus.c: In function ‘dxgvmb_send_query_alloc_residency’:
> drivers/hv/dxgkrnl/dxgvmbus.c:147:16: warning: array subscript ‘struct dxgvmbusmsg[0]’ is partly outside array bounds of ‘struct dxgvmbusmsgres[1]’ [-Warray-bounds]
>    147 |         if (msg->hdr && (char *)msg->hdr != msg->msg_on_stack)
>        |             ~~~^~~~~
> drivers/hv/dxgkrnl/dxgvmbus.c:1882:31: note: while referencing ‘msg’
>   1882 |         struct dxgvmbusmsgres msg = {.hdr = NULL};
>        |                               ^~~

Hi Nathan,

I fixed the issue with the ioctls array.

Regarding the warning above, it looks like a compiler error. I do not 
see where the out of bounds access is.
I tried GCC-11 version 11.2.0 and this warning is not there.

Thanks

Iouri

