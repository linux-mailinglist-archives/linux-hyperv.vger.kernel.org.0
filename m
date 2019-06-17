Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5EC491E2
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 23:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfFQVBE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 17:01:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40492 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfFQVBE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 17:01:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so4661671pla.7;
        Mon, 17 Jun 2019 14:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0jRUNf66WMJVyum8DcAIWA1CkRzKm9hKF96YC5ekRis=;
        b=SJR5Vv+4p1UbXlGD5fSqyxH3uGnCvpFeD/PcJL+oq7PxnIKYnZefze+GfSizbo+pMq
         S5THR6X73NQvFOf7F9FWERibBRXVmGr7i30HyhqmTfOiac9zPUuS+sSoKj9ViZYS//zD
         6HRjRyEiJXoHIdFHv8ts62sSI1JOclE3npBDtBDqoBFo2jS+2Vd5d5Q6R5gyctegt5fD
         OjAxWquK0RCONiHjlF7jnWVAnfSczvt4ZakzbfU0FgVzXcYoF6WKBsnZyhEuii5VF1Yy
         diLHigT6zP0S3ZLW+dEMIoAurlFckM/I184HtcGigWjtKmrcVVdEYIRYKFW5XPi7f5PN
         ENFQ==
X-Gm-Message-State: APjAAAWDlZ45ybwCxB5/RqoOnucetTtYw+sxjO9Z4K66s8J2fT4/XpS2
        YFOlLPuVi7xMypCfxHs96bfEKLH1AxE=
X-Google-Smtp-Source: APXvYqw3UGBjD229ZgVTVGkTzFaphbUTDp7VRH6rUHQL3KhTNuRhJQjVKzkrgsPGNwjJZew4WjgymA==
X-Received: by 2002:a17:902:d20f:: with SMTP id t15mr41254658ply.11.1560805263272;
        Mon, 17 Jun 2019 14:01:03 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id r6sm241839pji.0.2019.06.17.14.01.02
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 14:01:02 -0700 (PDT)
Subject: Re: [PATCH 6/8] IB/srp: set virt_boundary_mask in the scsi host
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190617122000.22181-1-hch@lst.de>
 <20190617122000.22181-7-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <840d9dbd-918b-d749-186a-3cc26d53fe76@acm.org>
Date:   Mon, 17 Jun 2019 14:01:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617122000.22181-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 6/17/19 5:19 AM, Christoph Hellwig wrote:
> This ensures all proper DMA layer handling is taken care of by the
> SCSI midlayer.

Acked-by: Bart Van Assche <bvanassche@acm.org>
