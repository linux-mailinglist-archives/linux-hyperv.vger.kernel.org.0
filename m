Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6528D363C0
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 21:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfFETGm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 15:06:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46378 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFETGm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 15:06:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id y11so15361369pfm.13
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Jun 2019 12:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Vx/AV9moqrhgu7Ph+ldHwoba6eE+vsY0eVf5PphJ6Q=;
        b=yEzqtrTHmwZC14RWz8x/UiqwPUR4E+4tGp7mIPm5QmEJ3HlJcxmNzYA0htdcpS43L8
         Mo2M2k23Cure6IGBdn+xEo5+u8BbOZCdCfuKldZSdHCdc3AbmQ9ncE/vnQwj+HqVGTRy
         kqsakZWdD4/kF82UvVDEztEYDdPt/+hySZMOWOJRlM954KknsvFVoBJWFcXatG8XVnVy
         jWVx3gg9IjA4mm8COkmVVZi19bPGA4B6kleA2c/kS8O4PHn+/zY7w6A/rJk9fvX9NRZ/
         3d95tHKpUWZDV+ffmm0NnyOc8ZlNQtruTJKXYyt2pJwfzOFquFRhY7Q6wgkXzZgAsSRO
         eH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Vx/AV9moqrhgu7Ph+ldHwoba6eE+vsY0eVf5PphJ6Q=;
        b=b6CU1CFshdIjPr7WpD37Wj58XWf9kvJf3ZNWZ7kWB3PRnpaMjpexovmGaV9Mt5VZyI
         SNexUOIwiJImvhUr7xSyh6rMvf/DR1IINbdLA1z+M/MOPVsSxJa+t56aBY+ME+VrfDQm
         z1nj6d2jDBdx2JgmkxahfvL7rxBr3wKAuJXtdvejin9ve41ge1+VV1pc49G25b4URjN9
         Al1nFbAbcLt5BvgOerpcGOJenqnk+SF1yYAK+cdPmMZC0H6GQX/0c0ljDxxaqo/Xovjj
         MoiI/COW8NmZs9yvUssfXI9Qy8jP2V3R/+DlQMzX/Fgji6u4yPbzSQiJ7rICANMjQ0Ax
         Y1FQ==
X-Gm-Message-State: APjAAAVkHVdTIKaQrBNA5L2twpOmhOoAqmkGe5yLeBiAo98TXdasHCcQ
        c5hiuetuX4stS/5ras3XGCAQj0zepfs=
X-Google-Smtp-Source: APXvYqzC9E1yp2G7Xyc1cwuJdKnyYxiQrsb5lhUKqgElieZfZJzFkChYrjRVO0RUtOQsIRIRs8KcZg==
X-Received: by 2002:a17:90a:b30a:: with SMTP id d10mr21505283pjr.8.1559761601785;
        Wed, 05 Jun 2019 12:06:41 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id r64sm29874790pfr.58.2019.06.05.12.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 12:06:41 -0700 (PDT)
Date:   Wed, 5 Jun 2019 12:06:40 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] revert async probing of VMBus scsi device
Message-ID: <20190605120640.00358689@hermes.lan>
In-Reply-To: <20190605185637.GA31439@infradead.org>
References: <20190605185205.12583-1-sthemmin@microsoft.com>
        <20190605185637.GA31439@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 5 Jun 2019 11:56:37 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Jun 05, 2019 at 11:52:05AM -0700, Stephen Hemminger wrote:
> > Doing asynchronous probing can lead to reordered device names
> > which is leads to failed mounts.  
> 
> Which is true for every device, and why we use UUIDs or label for
> mounts that are supposed to be stable.

Not everyone is smart enough to do that.
