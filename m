Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0B3642C42
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Dec 2022 16:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiLEPu4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Dec 2022 10:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiLEPuy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Dec 2022 10:50:54 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEFC13D2D;
        Mon,  5 Dec 2022 07:50:53 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id h33so10818418pgm.9;
        Mon, 05 Dec 2022 07:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FrdVQ7iK6l6qn5VcV6/rhrvsl7WqjE6gpvmfqgEIB6c=;
        b=ZTaM77ZzjC5tEyHjyTWLsWO6uPaP8582Vu4KcPTWvqcorWfNSLvHqM5rCW3qbpgqnX
         RvtHSdZBBFuBE5rUKu52Yj0yfGMFtE2sxxpUpRdJfXqfFhwXgFJ0o3qZVoz/FHv7yqbu
         z0714+dvCKUbCUEkoPox91Pl9LbXxyWWNxQn1HJu0otgH+bzQ2Jqf1YhIqCIfrL5eSYN
         wKhx8aU822O40VpkWUomJHVH1V3QRSyulmqXo8pURAvl0srYBo9PN3CYmS3zZXZ7VpmR
         vnq0oT1V8aO67J0hN2oCSutaSrlG7ia5JYo2VWD9eOYQtfRqccjhjA967lVVuQOrsYww
         vEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FrdVQ7iK6l6qn5VcV6/rhrvsl7WqjE6gpvmfqgEIB6c=;
        b=3gmJ/0A4O73Jr+MVOF4jPgbhTm3yDaiC94fKidu+5g3aB1AnLMopzrILceL4cAxnth
         twLxew2xbldfS3HZlH7n1y/HgBPXW+/hP6se4+bSukQEsy8nBhFG44vTDG5V/2z3OMl4
         u/aPTYFuUPAMWgmjd9iippm201BAV6Au3liXIn4kWKJMUg3SxPG9hoP8Qr9OWmUwH/hu
         csX9Af5a2fDrhRhGmqnFFoTuhCAfiYbriLJodYluGlbE4TwFC7xuflG/wrEf7njgzMpO
         AUa72UCwI8VpHyhaZWfRhQngClWhUnVoXIavTLbylFO/zR3Lo4xBBvtfz4vkbqxMayig
         Id/g==
X-Gm-Message-State: ANoB5pnM3L21SWyG3AEbnHglqYag0LwDmBAqvnW4BXn5e/GU4BArZTNZ
        wEV4jawJG5R1atJyZRF2rmtRMD4gEeyubNBw
X-Google-Smtp-Source: AA0mqf4tXNpEzYY0AlUhm+E+geXFUeu/L8oh7PwX+3aiB70sBpPeCUzX1z9/+MEKE9CYX1FDQ0NKzQ==
X-Received: by 2002:a63:ed0b:0:b0:477:9319:eb4f with SMTP id d11-20020a63ed0b000000b004779319eb4fmr58518947pgi.257.1670255452941;
        Mon, 05 Dec 2022 07:50:52 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:18:efec::75b])
        by smtp.gmail.com with ESMTPSA id y9-20020a170902ed4900b00189502c8c8bsm2862650plb.87.2022.12.05.07.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 07:50:52 -0800 (PST)
Message-ID: <ede2e83b-0f8e-fa75-9905-ebed8b2ea980@gmail.com>
Date:   Mon, 5 Dec 2022 23:50:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/1] scsi: storvsc: Fix swiotlb bounce buffer leak in
 confidential VM
To:     Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        martin.petersen@oracle.com, longli@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, jejb@linux.ibm.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <1670183564-76254-1-git-send-email-mikelley@microsoft.com>
Content-Language: en-US
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <1670183564-76254-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 12/5/2022 3:52 AM, Michael Kelley wrote:
> storvsc_queuecommand() maps the scatter/gather list using scsi_dma_map(),
> which in a confidential VM allocates swiotlb bounce buffers. If the
> I/O submission fails in storvsc_do_io(), the I/O is typically retried
> by higher level code, but the bounce buffer memory is never freed.
> The mostly like cause of I/O submission failure is a full VMBus
> channel ring buffer, which is not uncommon under high I/O loads.
> Eventually enough bounce buffer memory leaks that the confidential
> VM can't do any I/O. The same problem can arise in a non-confidential
> VM with kernel boot parameter swiotlb=force.
> 
> Fix this by doing scsi_dma_unmap() in the case of an I/O submission
> error, which frees the bounce buffer memory.
> 
> Fixes: 743b237c3a7b ("scsi: storvsc: Add Isolation VM support for storvsc driver")
> Signed-off-by: Michael Kelley<mikelley@microsoft.com>
Nice catch! Thanks to fix this.
Reviewed-by: Tianyu Lan <Tianyu.Lan@microsoft.com>


