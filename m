Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0B148A3C
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 19:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfFQRfI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 13:35:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38894 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfFQRfI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 13:35:08 -0400
Received: by mail-ot1-f65.google.com with SMTP id d17so10110344oth.5;
        Mon, 17 Jun 2019 10:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=FM2Q7ZOmlVoFwsuJQDbrn3PkqbHIxnRIpgV3g1ovINvWTJ+//zBB4/7vkDSfEFgWoQ
         +WqKju8P0rZT/UTt59Lyx83dFB8pPF8hkZY9+whx6TfxtrWPdDJjHRL5hu2HH7WyR7xj
         qHQiv+hrC/PuduuouWWKwe1ytv1AoZm6Ss4fJ3/vcEsBGXBTtLL8X0P0v30x4flFA++H
         DGsAorJ/+96KCJYSvy4EDcWmwh68XIPUAm1xec4Q8lNMaWqcHR8+nXwUhdAFowFEOWkH
         LjEkNvDgJNDQyvjrMfE2K+tV7nB0R/ziSK73uv2wjkIH24t3m1aXJ86dT3LC3JI/1yRC
         24nA==
X-Gm-Message-State: APjAAAVhmqVXOeX65zmzgno2QPbEOmApBarmaf7E7WzQngsYaaq4vLuC
        FqixJtMvjAk8JGaJMRBy2A5D6+GL
X-Google-Smtp-Source: APXvYqwN0qju9dtyrVDJLTxV0rvPxolJl3H38qslFsbaaN9rmLu8EL2nad9C/muzD7FHUWYwo2jf/w==
X-Received: by 2002:a9d:7245:: with SMTP id a5mr21278150otk.232.1560792906692;
        Mon, 17 Jun 2019 10:35:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id p13sm4642077otq.15.2019.06.17.10.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 10:35:05 -0700 (PDT)
Subject: Re: [PATCH 6/8] IB/srp: set virt_boundary_mask in the scsi host
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190617122000.22181-1-hch@lst.de>
 <20190617122000.22181-7-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d660e5ab-c1a9-a1dc-b63b-147a1b77b6e8@grimberg.me>
Date:   Mon, 17 Jun 2019 10:35:04 -0700
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
