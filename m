Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E4D6D69A1
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Apr 2023 18:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjDDQ51 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 Apr 2023 12:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjDDQ51 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 Apr 2023 12:57:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 644684C31;
        Tue,  4 Apr 2023 09:57:06 -0700 (PDT)
Received: from [192.168.0.5] (unknown [71.212.161.12])
        by linux.microsoft.com (Postfix) with ESMTPSA id 34043210DDAA;
        Tue,  4 Apr 2023 09:57:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 34043210DDAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680627420;
        bh=FUqsnQC3gtuWeZo8UtdQceQAvjRezk8c3IZXG3Y13BE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dcutaLzJ3PF4HECYl9Adtc+JeeLqcsJNV+hYVACu/ROluM81J0sOMtx7stW9GtyJD
         8BD3knwsoD1eSThryHKXR2qUxkjmUJGFt4B3rt9a+YEz1PkBki+tgBOO7V+Jl7o8k1
         g0KEGfRqPT6dNIG/xTONslifCxgvsQgqEqJmCvcs=
Message-ID: <e2a7504a-738d-f271-0a23-6d831af75936@linux.microsoft.com>
Date:   Tue, 4 Apr 2023 09:56:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] Drivers: hv: Use nested hypercall for post message and
 signal event
To:     Olaf Hering <olaf@aepfle.de>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com
References: <1680564178-31023-1-git-send-email-nunodasneves@linux.microsoft.com>
 <20230404084530.2b9ca791.olaf@aepfle.de>
Content-Language: en-US
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20230404084530.2b9ca791.olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 4/3/2023 11:45 PM, Olaf Hering wrote:
> Mon,  3 Apr 2023 16:22:58 -0700 Nuno Das Neves <nunodasneves@linux.microsoft.com>:
> 
>> Only relevant for x86; nested functionality is not available in ARM64.
> 
>> +#if defined(CONFIG_X86_64)
>> +	else if (hv_nested)
> 
> Should there be a hv_nested in the ARM64 code path?
> Looks like c4bdf94f97c86 provided such thing, so the Kconfig conditional could be removed.
> 
> Olaf

This will not compile on ARM64 without the guard, because hv_do_nested_hypercall and
hv_do_fast_nested_hypercall8 are not defined.
These are inline functions only defined in the x86 mshyperv.h header.

The alternative to these guards would be defining dummy inline functions for the nested
versions of hv_do_hypercall in the ARM64 mshyperv.h.
I could take that approach if it is preferable.
