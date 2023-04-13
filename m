Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4221F6E039E
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Apr 2023 03:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjDMBWn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Apr 2023 21:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDMBWm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Apr 2023 21:22:42 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D490A2D73;
        Wed, 12 Apr 2023 18:22:37 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id i3so3313043wrc.4;
        Wed, 12 Apr 2023 18:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681348956; x=1683940956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gv5zi7cMpM4A9Na3PQSkA4yff+YisIpjv+F3gYNEUW8=;
        b=LBhzMtxnhlwBRN/relcKzQIwggelztDK5QFUTE39+tDO6tX2kNQ03lDnfoRGJ+mg4p
         KDeHcAYBadA8jsLN+N8yOdPT2F+bZ0bJjB92UOFs5qKquP+2IIW4kllDf1bHDC6UryKK
         9ddZmFjP2UwO4uDCtv2zHFK+7I9uXTZHVF+upUtWc+1dpv4uXIoYQR2/9e7ekSL4MCPD
         6v5CCGjijjomX66aiF2CB2Pm6uwcecEoBHRBmeSLjeUi8vku7mSTqkb4/re7O9NxQRDd
         zRQzG7NDUtfWMQ/QpQz83xRrYN6gf6pWH/rAnj7ohSASwPbXLWvYwO09Zg0tcnH2Rpcm
         crUQ==
X-Gm-Message-State: AAQBX9fbfDefoE+iDDnVaexZkN8tUSDUjtYwwqxcsso0B1BXl4sZX0a8
        V/pSsdkfZuMDFDD9+KGVTe4=
X-Google-Smtp-Source: AKy350ZecMWgDPbDG08J3TZNwzEe/vq86IE6279renZo8RE8amcLVUe8n34Z/RXML3+mbbjxW/OZAA==
X-Received: by 2002:a5d:45c3:0:b0:2e0:f63a:2324 with SMTP id b3-20020a5d45c3000000b002e0f63a2324mr118469wrs.23.1681348956220;
        Wed, 12 Apr 2023 18:22:36 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r4-20020a5d4984000000b002db1b66ea8fsm119267wrq.57.2023.04.12.18.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 18:22:35 -0700 (PDT)
Date:   Thu, 13 Apr 2023 01:22:31 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jinank Jain <jinankjain@linux.microsoft.com>,
        g@liuwe-devbox-debian-v2
Cc:     jinankjain@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        nunodasneves@linux.microsoft.com
Subject: Re: [PATCH] PCI: hv: Use nested hypercall for retargeting interrupts
Message-ID: <ZDdZVw9Y0q7oT1FG@liuwe-devbox-debian-v2>
References: <20230404113546.856813-1-jinankjain@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404113546.856813-1-jinankjain@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 04, 2023 at 11:35:46AM +0000, Jinank Jain wrote:
> In case of nested MSHV, retargeting interrupt hypercall should be sent
> to L0 hypervisor instead of L1 hypervisor.
> 
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>

Applied to hyperv-next. Thanks.
