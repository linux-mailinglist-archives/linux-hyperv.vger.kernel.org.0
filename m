Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22CB348A36
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 19:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfFQRfA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 13:35:00 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:44915 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfFQRe7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 13:34:59 -0400
Received: by mail-ot1-f41.google.com with SMTP id b7so10062877otl.11;
        Mon, 17 Jun 2019 10:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
        b=XXzUfQ0ukktnJJaic1zggX+fWxjEYmzOzSxWn0jvsTXzULkD6ej0/2Fk078q3o8H82
         9COn1WwO4TQ4Lc+jTIO1CON/LQguijBILL0vHMmTUwiSH9LjHVWsyzNwBbCM/RP2+RrZ
         YlAC4Yy0rJ3vc/wSKTkQQLHet43MHbQwrWjGhc9YRnWYLRjfSgn07J9xwDjbG7+v1a6R
         M65I8hqTkzeiQ6V5YqvXKBik0H3Z+AtcZv1ID5Baul+pz6bx/TupUdm3BT/uriZlax8i
         WbAPB82sJNSUPCFHZUwa419eirgtnXc3fciWrmBIAgILSlCuDOi9OMP2ZBQ7wil0zaJV
         IoDg==
X-Gm-Message-State: APjAAAWkOdPrcdUeRLcxX+sQrJSS6YGFkDIiQg0yimd7AId8MRM0wjkr
        4I/IYLxsw/wmWu8p7OiVTq09a5rD
X-Google-Smtp-Source: APXvYqw4lPJrI+6zOs9y/O1bT7RZrUAy23CAA9kmsuPCQVBaNM+qFrJsL0hd5XEVKnvZDkd1ixC6PA==
X-Received: by 2002:a9d:3b84:: with SMTP id k4mr51257508otc.27.1560792897912;
        Mon, 17 Jun 2019 10:34:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id q8sm4732988oib.29.2019.06.17.10.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 10:34:57 -0700 (PDT)
Subject: Re: [PATCH 5/8] IB/iser: set virt_boundary_mask in the scsi host
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190617122000.22181-1-hch@lst.de>
 <20190617122000.22181-6-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <26fd5237-9a8a-3bda-ae6c-8825030f5ca5@grimberg.me>
Date:   Mon, 17 Jun 2019 10:34:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617122000.22181-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Acked-by: Sagi Grimberg <sagi@grimberg.me>
