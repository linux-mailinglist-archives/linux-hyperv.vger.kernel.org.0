Return-Path: <linux-hyperv+bounces-9583-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FZ2LFhcvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9583-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:28:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D382D21C0
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E673031D2CF9
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F1A3F9F28;
	Thu, 19 Mar 2026 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meEt66Gr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4992C3F8E1C
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951933; cv=none; b=kd7TPEmoadQSm5JKY4WmS7IT0cJkI3rUB3Ckfji3gtGHZHUUPBYmdjeLnBFoxrQE/x2K4q6VnFvDoPlzQEEuwuFNjKXOxzyWriKIeKFO6Ri3rLH4bU2wkrwao9l47ZAEaqDwV1qdyVCrrJ0LOJv8zvN+Tppi9IXYaZRoZC9T/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951933; c=relaxed/simple;
	bh=OcC5mzzGJ4jyW3tE/pecqqNwYt2+LrsdDdXg/j4BCaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzDy+/QyTkgMT1kvWIjyTlynGWZkpa96v+5Tuz23U7aIX4hn+tqj7sw5Yl2UdC3Le32NV0Mz3LZriRHPcyLa3yWXC+O0SQVe+YMytHJ5tV2A/Ht0q6RCJ/qDAek6IxQGf+nlmOfhpgMQVpgLxU56Oz3oVHY/YUu3wJo1ZCk1GP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meEt66Gr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so14218715e9.3
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951926; x=1774556726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAZE4/6c4RcyDRxzDQdEx/qHk8QrzPDuRZgVPNWiHNg=;
        b=meEt66Gr6HuxmN0SLCazPjZOkeCoVMAecRyHsddhgKN8oVUrSuOOG+rjYU3808GUYo
         t/g5pnLg9Dw2AWZRT1eqQrp/fywtyI3o4k4A3LpR9pbhuGVTpEjLF5YOqsktqsSgWYYr
         GZwEN20a1gPM+IBNLP37ugMCeH0kXG+joJT7A8aswbIE6x+a/4gT2Q0Y6egs8GWn2g4a
         /c+kdV0ECc4fe+sCE1Mw0dgV8eTQoP7qXHJLKTvl842H40hZ+HXuHcGKAP6ut2WeWm0R
         KBdFWYgscj7v+/sXeveDJpPMU0OghgaFIh4o1Xf8pxBlBmFcJs0GZKGy6cZyd8ifpsgI
         C4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951926; x=1774556726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oAZE4/6c4RcyDRxzDQdEx/qHk8QrzPDuRZgVPNWiHNg=;
        b=SNnXJWcLHHTFlFFDOXq5K0aLLiQbFE69vSj2fEsuhsr/j2QBNxrdgtIJvXCqCOKadi
         R9xjQ58ROLyfafGHDZlP6/ky/WBL3wB6KBJ7Y1tcsO3WL1AXt9uqP0OwbDy8DPD3a9BQ
         d03awnzB8CAUGVvkTUY7yvEqetEOWY8pJsqbwCQMUIWSAB9nsvO/arB33btuPv64Hm08
         pYJhXlNh8Q6GaSEFdyvoqIuIeUY6ZeGYzffveCh4WhfI05OIu2pXPFarm4blMMRvpjUp
         qxulcIsB8MytK+QiS+F0owZNWwe4K6BI3LfQHjgrBF6mZVR87dTLbKViq+I4PLcw1kAz
         XxNw==
X-Gm-Message-State: AOJu0YzFyRjT+7l+fBOZ52sp9TQmj6n5nYxPldks0aqJRMW7uN74dbo4
	S6ZnZr31hGtfLG9jnPXjWUs7M0Oex0BdhhyL3MteBdqFb30ZuboqnGXqy8H/VEaGElY=
X-Gm-Gg: ATEYQzzpRcxQomv7ieMX8l+j3eXGvIyadKehrUaqP4kyhZmI4KC5rgm89jDBNKjLHmS
	Dkobm4Dd3D2NJaXoRJFOCVYFbVET/7OCMyusrfX8dnH03dbL8aiz/eQZ6iECd4jO5d8+HrTYQJU
	cdKVcwI9qYYX5qhCMkaqpdeKZy/UjS1kzNl3ylYDNvLOiGNDVSZYXWB1V8dlfdt10708F3QlIwY
	Nklsd1XLjzf5rFuLCH9TYu50NxJB2F3iK+mQqWZJDz7qiBRxMSHcbkxdJHCqBB9HkouCT2AgZN5
	3xBKnXPMiEtLdOVdvDJKm8LEGNWap0SRow3w7qestCJtVkI3eqZiAI7b4cfUW+Wn991fbr4ddk2
	TtHU9DtnPTnGOltmvfkOqGkH8zI5D9N7GXXn627bjjsSpfDrS6PT5Y9RcujwQinpToa7oAmjxMr
	Ab68e33g7ybXCIPx8j+VlFvD4ZALrKFUze1b+OguDp2iOX9KAl
X-Received: by 2002:a05:600c:c083:b0:485:3f72:324d with SMTP id 5b1f17b1804b1-486fee0481amr5002735e9.14.1773951926227;
        Thu, 19 Mar 2026 13:25:26 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:25 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 11/55] drivers: hv: dxgkrnl: Sharing of dxgresource objects
Date: Thu, 19 Mar 2026 20:24:25 +0000
Message-ID: <20260319202509.63802-12-eric.curtin@docker.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319202509.63802-1-eric.curtin@docker.com>
References: <20260319202509.63802-1-eric.curtin@docker.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9583-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.982];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34D382D21C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement creation of shared resources and ioctls for sharing
dxgresource objects between processes in the virtual machine.

A dxgresource object is a collection of dxgallocation objects.
The driver API allows addition/removal of allocations to a resource,
but has limitations on addition/removal of allocations to a shared
resource. When a resource is "sealed", addition/removal of allocations
is not allowed.

Resources are shared using file descriptor (FD) handles. The name
"NT handle" is used to be compatible with Windows implementation.

An FD handle is created by the LX_DXSHAREOBJECTS ioctl. The given FD
handle could be sent to another process using any Linux API.

To use a shared resource object in other ioctls the object needs to be
opened using its FD handle. An resource object is opened by the
LX_DXOPENRESOURCEFROMNTHANDLE ioctl. This ioctl returns a d3dkmthandle
value, which can be used to reference the resource object.

The LX_DXQUERYRESOURCEINFOFROMNTHANDLE ioctl is used to query private
driver data of a shared resource object. This private data needs to be
used to actually open the object using the LX_DXOPENRESOURCEFROMNTHANDLE
ioctl.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c |  81 ++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  77 ++++
 drivers/hv/dxgkrnl/dxgmodule.c  |   1 +
 drivers/hv/dxgkrnl/dxgvmbus.c   | 127 +++++
 drivers/hv/dxgkrnl/dxgvmbus.h   |  30 ++
 drivers/hv/dxgkrnl/ioctl.c      | 792 +++++++++++++++++++++++++++++++-
 include/uapi/misc/d3dkmthk.h    |  96 ++++
 7 files changed, 1200 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index 04d827a15c54..26fce9aba4f3 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -160,6 +160,17 @@ void dxgadapter_remove_process(struct dxgprocess_adapter *process_info)
 	list_del(&process_info->adapter_process_list_entry);
 }
 
+void dxgadapter_remove_shared_resource(struct dxgadapter *adapter,
+				       struct dxgsharedresource *object)
+{
+	down_write(&adapter->shared_resource_list_lock);
+	if (object->shared_resource_list_entry.next) {
+		list_del(&object->shared_resource_list_entry);
+		object->shared_resource_list_entry.next = NULL;
+	}
+	up_write(&adapter->shared_resource_list_lock);
+}
+
 void dxgadapter_add_syncobj(struct dxgadapter *adapter,
 			    struct dxgsyncobject *object)
 {
@@ -489,6 +500,69 @@ void dxgdevice_remove_resource(struct dxgdevice *device,
 	}
 }
 
+struct dxgsharedresource *dxgsharedresource_create(struct dxgadapter *adapter)
+{
+	struct dxgsharedresource *resource;
+
+	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
+	if (resource) {
+		INIT_LIST_HEAD(&resource->resource_list_head);
+		kref_init(&resource->sresource_kref);
+		mutex_init(&resource->fd_mutex);
+		resource->adapter = adapter;
+	}
+	return resource;
+}
+
+void dxgsharedresource_destroy(struct kref *refcount)
+{
+	struct dxgsharedresource *resource;
+
+	resource = container_of(refcount, struct dxgsharedresource,
+				sresource_kref);
+	if (resource->runtime_private_data)
+		vfree(resource->runtime_private_data);
+	if (resource->resource_private_data)
+		vfree(resource->resource_private_data);
+	if (resource->alloc_private_data_sizes)
+		vfree(resource->alloc_private_data_sizes);
+	if (resource->alloc_private_data)
+		vfree(resource->alloc_private_data);
+	kfree(resource);
+}
+
+void dxgsharedresource_add_resource(struct dxgsharedresource *shared_resource,
+				    struct dxgresource *resource)
+{
+	down_write(&shared_resource->adapter->shared_resource_list_lock);
+	DXG_TRACE("Adding resource: %p %p", shared_resource, resource);
+	list_add_tail(&resource->shared_resource_list_entry,
+		      &shared_resource->resource_list_head);
+	kref_get(&shared_resource->sresource_kref);
+	kref_get(&resource->resource_kref);
+	resource->shared_owner = shared_resource;
+	up_write(&shared_resource->adapter->shared_resource_list_lock);
+}
+
+void dxgsharedresource_remove_resource(struct dxgsharedresource
+				       *shared_resource,
+				       struct dxgresource *resource)
+{
+	struct dxgadapter *adapter = shared_resource->adapter;
+
+	down_write(&adapter->shared_resource_list_lock);
+	DXG_TRACE("Removing resource: %p %p", shared_resource, resource);
+	if (resource->shared_resource_list_entry.next) {
+		list_del(&resource->shared_resource_list_entry);
+		resource->shared_resource_list_entry.next = NULL;
+		kref_put(&shared_resource->sresource_kref,
+			 dxgsharedresource_destroy);
+		resource->shared_owner = NULL;
+		kref_put(&resource->resource_kref, dxgresource_release);
+	}
+	up_write(&adapter->shared_resource_list_lock);
+}
+
 struct dxgresource *dxgresource_create(struct dxgdevice *device)
 {
 	struct dxgresource *resource;
@@ -532,6 +606,7 @@ void dxgresource_destroy(struct dxgresource *resource)
 	struct d3dkmt_destroyallocation2 args = { };
 	int destroyed = test_and_set_bit(0, &resource->flags);
 	struct dxgdevice *device = resource->device;
+	struct dxgsharedresource *shared_resource;
 
 	if (!destroyed) {
 		dxgresource_free_handle(resource);
@@ -547,6 +622,12 @@ void dxgresource_destroy(struct dxgresource *resource)
 			dxgallocation_destroy(alloc);
 		}
 		dxgdevice_remove_resource(device, resource);
+		shared_resource = resource->shared_owner;
+		if (shared_resource) {
+			dxgsharedresource_remove_resource(shared_resource,
+							  resource);
+			resource->shared_owner = NULL;
+		}
 	}
 	kref_put(&resource->resource_kref, dxgresource_release);
 }
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 8431523f42de..0336e1843223 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -38,6 +38,7 @@ struct dxgdevice;
 struct dxgcontext;
 struct dxgallocation;
 struct dxgresource;
+struct dxgsharedresource;
 struct dxgsyncobject;
 
 /*
@@ -372,6 +373,8 @@ struct dxgadapter {
 	struct list_head	adapter_list_entry;
 	/* The list of dxgprocess_adapter entries */
 	struct list_head	adapter_process_list_head;
+	/* List of all dxgsharedresource objects */
+	struct list_head	shared_resource_list_head;
 	/* List of all non-device dxgsyncobject objects */
 	struct list_head	syncobj_list_head;
 	/* This lock protects shared resource and syncobject lists */
@@ -405,6 +408,8 @@ void dxgadapter_remove_syncobj(struct dxgsyncobject *so);
 void dxgadapter_add_process(struct dxgadapter *adapter,
 			    struct dxgprocess_adapter *process_info);
 void dxgadapter_remove_process(struct dxgprocess_adapter *process_info);
+void dxgadapter_remove_shared_resource(struct dxgadapter *adapter,
+				       struct dxgsharedresource *object);
 
 /*
  * The object represent the device object.
@@ -484,6 +489,64 @@ void dxgcontext_destroy_safe(struct dxgprocess *pr, struct dxgcontext *ctx);
 void dxgcontext_release(struct kref *refcount);
 bool dxgcontext_is_active(struct dxgcontext *ctx);
 
+/*
+ * A shared resource object is created to track the list of dxgresource objects,
+ * which are opened for the same underlying shared resource.
+ * Objects are shared by using a file descriptor handle.
+ * FD is created by calling dxgk_share_objects and providing shandle to
+ * dxgsharedresource. The FD points to a dxgresource object, which is created
+ * by calling dxgk_open_resource_nt.  dxgresource object is referenced by the
+ * FD.
+ *
+ * The object is referenced by every dxgresource in its list.
+ *
+ */
+struct dxgsharedresource {
+	/* Every dxgresource object in the resource list takes a reference */
+	struct kref		sresource_kref;
+	struct dxgadapter	*adapter;
+	/* List of dxgresource objects, opened for the shared resource. */
+	/* Protected by dxgadapter::shared_resource_list_lock */
+	struct list_head	resource_list_head;
+	/* Entry in the list of dxgsharedresource in dxgadapter */
+	/* Protected by dxgadapter::shared_resource_list_lock */
+	struct list_head	shared_resource_list_entry;
+	struct mutex		fd_mutex;
+	/* Referenced by file descriptors */
+	int			host_shared_handle_nt_reference;
+	/* Corresponding global handle in the host */
+	struct d3dkmthandle	host_shared_handle;
+	/*
+	 * When the sync object is shared by NT handle, this is the
+	 * corresponding handle in the host
+	 */
+	struct d3dkmthandle	host_shared_handle_nt;
+	/* Values below are computed when the resource is sealed */
+	u32			runtime_private_data_size;
+	u32			alloc_private_data_size;
+	u32			resource_private_data_size;
+	u32			allocation_count;
+	union {
+		struct {
+			/* Cannot add new allocations */
+			u32	sealed:1;
+			u32	reserved:31;
+		};
+		long		flags;
+	};
+	u32			*alloc_private_data_sizes;
+	u8			*alloc_private_data;
+	u8			*runtime_private_data;
+	u8			*resource_private_data;
+};
+
+struct dxgsharedresource *dxgsharedresource_create(struct dxgadapter *adapter);
+void dxgsharedresource_destroy(struct kref *refcount);
+void dxgsharedresource_add_resource(struct dxgsharedresource *sres,
+				    struct dxgresource *res);
+void dxgsharedresource_remove_resource(struct dxgsharedresource *sres,
+				       struct dxgresource *res);
+
 struct dxgresource {
 	struct kref		resource_kref;
 	enum dxgobjectstate	object_state;
@@ -504,6 +567,8 @@ struct dxgresource {
 		};
 		long		flags;
 	};
+	/* Owner of the shared resource */
+	struct dxgsharedresource *shared_owner;
 };
 
 struct dxgresource *dxgresource_create(struct dxgdevice *dev);
@@ -658,6 +723,18 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args);
+int dxgvmb_send_create_nt_shared_object(struct dxgprocess *process,
+					struct d3dkmthandle object,
+					struct d3dkmthandle *shared_handle);
+int dxgvmb_send_destroy_nt_shared_object(struct d3dkmthandle shared_handle);
+int dxgvmb_send_open_resource(struct dxgprocess *process,
+			      struct dxgadapter *adapter,
+			      struct d3dkmthandle device,
+			      struct d3dkmthandle global_share,
+			      u32 allocation_count,
+			      u32 total_priv_drv_data_size,
+			      struct d3dkmthandle *resource_handle,
+			      struct d3dkmthandle *alloc_handles);
 int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 				  enum d3dkmdt_standardallocationtype t,
 				  struct d3dkmdt_gdisurfacedata *data,
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index 5a5ca8791d27..69e221613af9 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -258,6 +258,7 @@ int dxgglobal_create_adapter(struct pci_dev *dev, guid_t *guid,
 	init_rwsem(&adapter->core_lock);
 
 	INIT_LIST_HEAD(&adapter->adapter_process_list_head);
+	INIT_LIST_HEAD(&adapter->shared_resource_list_head);
 	INIT_LIST_HEAD(&adapter->syncobj_list_head);
 	init_rwsem(&adapter->shared_resource_list_lock);
 	adapter->pci_dev = dev;
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 6b2dea24a509..b3a4377c8b0b 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -712,6 +712,79 @@ int dxgvmb_send_destroy_process(struct d3dkmthandle process)
 	return ret;
 }
 
+int dxgvmb_send_create_nt_shared_object(struct dxgprocess *process,
+					struct d3dkmthandle object,
+					struct d3dkmthandle *shared_handle)
+{
+	struct dxgkvmb_command_createntsharedobject *command;
+	int ret;
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, NULL, process, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vm_to_host_init2(&command->hdr,
+				 DXGK_VMBCOMMAND_CREATENTSHAREDOBJECT,
+				 process->host_handle);
+	command->object = object;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+
+	ret = dxgvmb_send_sync_msg(dxgglobal_get_dxgvmbuschannel(),
+				   msg.hdr, msg.size, shared_handle,
+				   sizeof(*shared_handle));
+
+	dxgglobal_release_channel_lock();
+
+	if (ret < 0)
+		goto cleanup;
+	if (shared_handle->v == 0) {
+		DXG_ERR("failed to create NT shared object");
+		ret = -ENOTRECOVERABLE;
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
+int dxgvmb_send_destroy_nt_shared_object(struct d3dkmthandle shared_handle)
+{
+	struct dxgkvmb_command_destroyntsharedobject *command;
+	int ret;
+	struct dxgvmbusmsg msg;
+
+	ret = init_message(&msg, NULL, NULL, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	command_vm_to_host_init1(&command->hdr,
+				 DXGK_VMBCOMMAND_DESTROYNTSHAREDOBJECT);
+	command->shared_handle = shared_handle;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+
+	ret = dxgvmb_send_sync_msg_ntstatus(dxgglobal_get_dxgvmbuschannel(),
+					    msg.hdr, msg.size);
+
+	dxgglobal_release_channel_lock();
+
+cleanup:
+	free_message(&msg, NULL);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 int dxgvmb_send_destroy_sync_object(struct dxgprocess *process,
 				    struct d3dkmthandle sync_object)
 {
@@ -1552,6 +1625,60 @@ int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_open_resource(struct dxgprocess *process,
+			      struct dxgadapter *adapter,
+			      struct d3dkmthandle device,
+			      struct d3dkmthandle global_share,
+			      u32 allocation_count,
+			      u32 total_priv_drv_data_size,
+			      struct d3dkmthandle *resource_handle,
+			      struct d3dkmthandle *alloc_handles)
+{
+	struct dxgkvmb_command_openresource *command;
+	struct dxgkvmb_command_openresource_return *result;
+	struct d3dkmthandle *handles;
+	int ret;
+	int i;
+	u32 result_size = allocation_count * sizeof(struct d3dkmthandle) +
+			   sizeof(*result);
+	struct dxgvmbusmsgres msg = {.hdr = NULL};
+
+	ret = init_message_res(&msg, adapter, process, sizeof(*command),
+			       result_size);
+	if (ret)
+		goto cleanup;
+	command = msg.msg;
+	result = msg.res;
+
+	command_vgpu_to_host_init2(&command->hdr, DXGK_VMBCOMMAND_OPENRESOURCE,
+				   process->host_handle);
+	command->device = device;
+	command->nt_security_sharing = 1;
+	command->global_share = global_share;
+	command->allocation_count = allocation_count;
+	command->total_priv_drv_data_size = total_priv_drv_data_size;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   result, msg.res_size);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = ntstatus2int(result->status);
+	if (ret < 0)
+		goto cleanup;
+
+	*resource_handle = result->resource;
+	handles = (struct d3dkmthandle *) &result[1];
+	for (i = 0; i < allocation_count; i++)
+		alloc_handles[i] = handles[i];
+
+cleanup:
+	free_message((struct dxgvmbusmsg *)&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 				  enum d3dkmdt_standardallocationtype alloctype,
 				  struct d3dkmdt_gdisurfacedata *alloc_data,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 89fecbcefbc8..73d7adac60a1 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -172,6 +172,21 @@ struct dxgkvmb_command_signalguestevent {
 	bool				dereference_event;
 };
 
+/*
+ * The command returns struct d3dkmthandle of a shared object for the
+ * given pre-process object
+ */
+struct dxgkvmb_command_createntsharedobject {
+	struct dxgkvmb_command_vm_to_host hdr;
+	struct d3dkmthandle		object;
+};
+
+/* The command returns ntstatus */
+struct dxgkvmb_command_destroyntsharedobject {
+	struct dxgkvmb_command_vm_to_host hdr;
+	struct d3dkmthandle		shared_handle;
+};
+
 /* Returns ntstatus */
 struct dxgkvmb_command_setiospaceregion {
 	struct dxgkvmb_command_vm_to_host hdr;
@@ -305,6 +320,21 @@ struct dxgkvmb_command_createallocation {
 /* u8 priv_drv_data[] for each alloc_info */
 };
 
+struct dxgkvmb_command_openresource {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	bool				nt_security_sharing;
+	struct d3dkmthandle		global_share;
+	u32				allocation_count;
+	u32				total_priv_drv_data_size;
+};
+
+struct dxgkvmb_command_openresource_return {
+	struct d3dkmthandle		resource;
+	struct ntstatus			status;
+/* struct d3dkmthandle   allocation[allocation_count]; */
+};
+
 struct dxgkvmb_command_getstandardallocprivdata {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	enum d3dkmdt_standardallocationtype alloc_type;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 0025e1ee2d4d..abb64f6c3a59 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -36,8 +36,35 @@ static char *errorstr(int ret)
 }
 #endif
 
+static int dxgsharedresource_release(struct inode *inode, struct file *file)
+{
+	struct dxgsharedresource *resource = file->private_data;
+
+	DXG_TRACE("Release resource: %p", resource);
+	mutex_lock(&resource->fd_mutex);
+	kref_get(&resource->sresource_kref);
+	resource->host_shared_handle_nt_reference--;
+	if (resource->host_shared_handle_nt_reference == 0) {
+		if (resource->host_shared_handle_nt.v) {
+			dxgvmb_send_destroy_nt_shared_object(
+					resource->host_shared_handle_nt);
+			DXG_TRACE("Resource host_handle_nt destroyed: %x",
+				resource->host_shared_handle_nt.v);
+			resource->host_shared_handle_nt.v = 0;
+		}
+		kref_put(&resource->sresource_kref, dxgsharedresource_destroy);
+	}
+	mutex_unlock(&resource->fd_mutex);
+	kref_put(&resource->sresource_kref, dxgsharedresource_destroy);
+	return 0;
+}
+
+static const struct file_operations dxg_resource_fops = {
+	.release = dxgsharedresource_release,
+};
+
 static int dxgkio_open_adapter_from_luid(struct dxgprocess *process,
-					void *__user inargs)
+						   void *__user inargs)
 {
 	struct d3dkmt_openadapterfromluid args;
 	int ret;
@@ -212,6 +239,98 @@ dxgkp_enum_adapters(struct dxgprocess *process,
 	return ret;
 }
 
+static int dxgsharedresource_seal(struct dxgsharedresource *shared_resource)
+{
+	int ret = 0;
+	int i = 0;
+	u8 *private_data;
+	u32 data_size;
+	struct dxgresource *resource;
+	struct dxgallocation *alloc;
+
+	DXG_TRACE("Sealing resource: %p", shared_resource);
+
+	down_write(&shared_resource->adapter->shared_resource_list_lock);
+	if (shared_resource->sealed) {
+		DXG_TRACE("Resource already sealed");
+		goto cleanup;
+	}
+	shared_resource->sealed = 1;
+	if (!list_empty(&shared_resource->resource_list_head)) {
+		resource =
+		    list_first_entry(&shared_resource->resource_list_head,
+				     struct dxgresource,
+				     shared_resource_list_entry);
+		DXG_TRACE("First resource: %p", resource);
+		mutex_lock(&resource->resource_mutex);
+		list_for_each_entry(alloc, &resource->alloc_list_head,
+				    alloc_list_entry) {
+			DXG_TRACE("Resource alloc: %p %d", alloc,
+				alloc->priv_drv_data->data_size);
+			shared_resource->allocation_count++;
+			shared_resource->alloc_private_data_size +=
+			    alloc->priv_drv_data->data_size;
+			if (shared_resource->alloc_private_data_size <
+			    alloc->priv_drv_data->data_size) {
+				DXG_ERR("alloc private data overflow");
+				ret = -EINVAL;
+				goto cleanup1;
+			}
+		}
+		if (shared_resource->alloc_private_data_size == 0) {
+			ret = -EINVAL;
+			goto cleanup1;
+		}
+		shared_resource->alloc_private_data =
+			vzalloc(shared_resource->alloc_private_data_size);
+		if (shared_resource->alloc_private_data == NULL) {
+			ret = -EINVAL;
+			goto cleanup1;
+		}
+		shared_resource->alloc_private_data_sizes =
+			vzalloc(sizeof(u32)*shared_resource->allocation_count);
+		if (shared_resource->alloc_private_data_sizes == NULL) {
+			ret = -EINVAL;
+			goto cleanup1;
+		}
+		private_data = shared_resource->alloc_private_data;
+		data_size = shared_resource->alloc_private_data_size;
+		i = 0;
+		list_for_each_entry(alloc, &resource->alloc_list_head,
+				    alloc_list_entry) {
+			u32 alloc_data_size = alloc->priv_drv_data->data_size;
+
+			if (alloc_data_size) {
+				if (data_size < alloc_data_size) {
+					dev_err(DXGDEV,
+						"Invalid private data size");
+					ret = -EINVAL;
+					goto cleanup1;
+				}
+				shared_resource->alloc_private_data_sizes[i] =
+				    alloc_data_size;
+				memcpy(private_data,
+				       alloc->priv_drv_data->data,
+				       alloc_data_size);
+				vfree(alloc->priv_drv_data);
+				alloc->priv_drv_data = NULL;
+				private_data += alloc_data_size;
+				data_size -= alloc_data_size;
+			}
+			i++;
+		}
+		if (data_size != 0) {
+			DXG_ERR("Data size mismatch");
+			ret = -EINVAL;
+		}
+cleanup1:
+		mutex_unlock(&resource->resource_mutex);
+	}
+cleanup:
+	up_write(&shared_resource->adapter->shared_resource_list_lock);
+	return ret;
+}
+
 static int
 dxgkio_enum_adapters(struct dxgprocess *process, void *__user inargs)
 {
@@ -803,6 +922,7 @@ dxgkio_create_allocation(struct dxgprocess *process, void *__user inargs)
 	u32 alloc_info_size = 0;
 	struct dxgresource *resource = NULL;
 	struct dxgallocation **dxgalloc = NULL;
+	struct dxgsharedresource *shared_resource = NULL;
 	bool resource_mutex_acquired = false;
 	u32 standard_alloc_priv_data_size = 0;
 	void *standard_alloc_priv_data = NULL;
@@ -973,6 +1093,76 @@ dxgkio_create_allocation(struct dxgprocess *process, void *__user inargs)
 		}
 		resource->private_runtime_handle =
 		    args.private_runtime_resource_handle;
+		if (args.flags.create_shared) {
+			if (!args.flags.nt_security_sharing) {
+				dev_err(DXGDEV,
+					"nt_security_sharing must be set");
+				ret = -EINVAL;
+				goto cleanup;
+			}
+			shared_resource = dxgsharedresource_create(adapter);
+			if (shared_resource == NULL) {
+				ret = -ENOMEM;
+				goto cleanup;
+			}
+			shared_resource->runtime_private_data_size =
+			    args.priv_drv_data_size;
+			shared_resource->resource_private_data_size =
+			    args.priv_drv_data_size;
+
+			shared_resource->runtime_private_data_size =
+			    args.private_runtime_data_size;
+			shared_resource->resource_private_data_size =
+			    args.priv_drv_data_size;
+			dxgsharedresource_add_resource(shared_resource,
+						       resource);
+			if (args.flags.standard_allocation) {
+				shared_resource->resource_private_data =
+					res_priv_data;
+				shared_resource->resource_private_data_size =
+					res_priv_data_size;
+				res_priv_data = NULL;
+			}
+			if (args.private_runtime_data_size) {
+				shared_resource->runtime_private_data =
+				    vzalloc(args.private_runtime_data_size);
+				if (shared_resource->runtime_private_data ==
+				    NULL) {
+					ret = -ENOMEM;
+					goto cleanup;
+				}
+				ret = copy_from_user(
+					shared_resource->runtime_private_data,
+					args.private_runtime_data,
+					args.private_runtime_data_size);
+				if (ret) {
+					dev_err(DXGDEV,
+						"failed to copy runtime data");
+					ret = -EINVAL;
+					goto cleanup;
+				}
+			}
+			if (args.priv_drv_data_size &&
+			    !args.flags.standard_allocation) {
+				shared_resource->resource_private_data =
+				    vzalloc(args.priv_drv_data_size);
+				if (shared_resource->resource_private_data ==
+				    NULL) {
+					ret = -ENOMEM;
+					goto cleanup;
+				}
+				ret = copy_from_user(
+					shared_resource->resource_private_data,
+					args.priv_drv_data,
+					args.priv_drv_data_size);
+				if (ret) {
+					dev_err(DXGDEV,
+						"failed to copy res data");
+					ret = -EINVAL;
+					goto cleanup;
+				}
+			}
+		}
 	} else {
 		if (args.resource.v) {
 			/* Adding new allocations to the given resource */
@@ -991,6 +1181,12 @@ dxgkio_create_allocation(struct dxgprocess *process, void *__user inargs)
 				ret = -EINVAL;
 				goto cleanup;
 			}
+			if (resource->shared_owner &&
+			    resource->shared_owner->sealed) {
+				DXG_ERR("Resource is sealed");
+				ret = -EINVAL;
+				goto cleanup;
+			}
 			/* Synchronize with resource destruction */
 			mutex_lock(&resource->resource_mutex);
 			if (!dxgresource_is_active(resource)) {
@@ -1092,9 +1288,16 @@ dxgkio_create_allocation(struct dxgprocess *process, void *__user inargs)
 			}
 		}
 		if (resource && args.flags.create_resource) {
+			if (shared_resource) {
+				dxgsharedresource_remove_resource
+				    (shared_resource, resource);
+			}
 			dxgresource_destroy(resource);
 		}
 	}
+	if (shared_resource)
+		kref_put(&shared_resource->sresource_kref,
+			 dxgsharedresource_destroy);
 	if (dxgalloc)
 		vfree(dxgalloc);
 	if (standard_alloc_priv_data)
@@ -1140,6 +1343,10 @@ static int validate_alloc(struct dxgallocation *alloc0,
 			fail_reason = 4;
 			goto cleanup;
 		}
+		if (alloc->owner.resource->shared_owner) {
+			fail_reason = 5;
+			goto cleanup;
+		}
 	} else {
 		if (alloc->owner.device != device) {
 			fail_reason = 6;
@@ -2146,6 +2353,582 @@ dxgkio_wait_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgsharedresource_get_host_nt_handle(struct dxgsharedresource *resource,
+				     struct dxgprocess *process,
+				     struct d3dkmthandle objecthandle)
+{
+	int ret = 0;
+
+	mutex_lock(&resource->fd_mutex);
+	if (resource->host_shared_handle_nt_reference == 0) {
+		ret = dxgvmb_send_create_nt_shared_object(process,
+					objecthandle,
+					&resource->host_shared_handle_nt);
+		if (ret < 0)
+			goto cleanup;
+		DXG_TRACE("Resource host_shared_handle_ht: %x",
+			resource->host_shared_handle_nt.v);
+		kref_get(&resource->sresource_kref);
+	}
+	resource->host_shared_handle_nt_reference++;
+cleanup:
+	mutex_unlock(&resource->fd_mutex);
+	return ret;
+}
+
+enum dxg_sharedobject_type {
+	DXG_SHARED_RESOURCE
+};
+
+static int get_object_fd(enum dxg_sharedobject_type type,
+				     void *object, int *fdout)
+{
+	struct file *file;
+	int fd;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		DXG_ERR("get_unused_fd_flags failed: %x", fd);
+		return -ENOTRECOVERABLE;
+	}
+
+	switch (type) {
+	case DXG_SHARED_RESOURCE:
+		file = anon_inode_getfile("dxgresource",
+					  &dxg_resource_fops, object, 0);
+		break;
+	default:
+		return -EINVAL;
+	};
+	if (IS_ERR(file)) {
+		DXG_ERR("anon_inode_getfile failed: %x", fd);
+		put_unused_fd(fd);
+		return -ENOTRECOVERABLE;
+	}
+
+	fd_install(fd, file);
+	*fdout = fd;
+	return 0;
+}
+
+static int
+dxgkio_share_objects(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_shareobjects args;
+	enum hmgrentry_type object_type;
+	struct dxgsyncobject *syncobj = NULL;
+	struct dxgresource *resource = NULL;
+	struct dxgsharedresource *shared_resource = NULL;
+	struct d3dkmthandle *handles = NULL;
+	int object_fd = -1;
+	void *obj = NULL;
+	u32 handle_size;
+	int ret;
+	u64 tmp = 0;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.object_count == 0 || args.object_count > 1) {
+		DXG_ERR("invalid object count %d", args.object_count);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	handle_size = args.object_count * sizeof(struct d3dkmthandle);
+
+	handles = vzalloc(handle_size);
+	if (handles == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	ret = copy_from_user(handles, args.objects, handle_size);
+	if (ret) {
+		DXG_ERR("failed to copy object handles");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	DXG_TRACE("Sharing handle: %x", handles[0].v);
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_SHARED);
+	object_type = hmgrtable_get_object_type(&process->handle_table,
+						handles[0]);
+	obj = hmgrtable_get_object(&process->handle_table, handles[0]);
+	if (obj == NULL) {
+		DXG_ERR("invalid object handle %x", handles[0].v);
+		ret = -EINVAL;
+	} else {
+		switch (object_type) {
+		case HMGRENTRY_TYPE_DXGRESOURCE:
+			resource = obj;
+			if (resource->shared_owner) {
+				kref_get(&resource->resource_kref);
+				shared_resource = resource->shared_owner;
+			} else {
+				resource = NULL;
+				DXG_ERR("resource object shared");
+				ret = -EINVAL;
+			}
+			break;
+		default:
+			DXG_ERR("invalid object type %d", object_type);
+			ret = -EINVAL;
+			break;
+		}
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_SHARED);
+
+	if (ret < 0)
+		goto cleanup;
+
+	switch (object_type) {
+	case HMGRENTRY_TYPE_DXGRESOURCE:
+		ret = get_object_fd(DXG_SHARED_RESOURCE, shared_resource,
+				    &object_fd);
+		if (ret < 0) {
+			DXG_ERR("get_object_fd failed for resource");
+			goto cleanup;
+		}
+		ret = dxgsharedresource_get_host_nt_handle(shared_resource,
+							   process, handles[0]);
+		if (ret < 0) {
+			DXG_ERR("get_host_res_nt_handle failed");
+			goto cleanup;
+		}
+		ret = dxgsharedresource_seal(shared_resource);
+		if (ret < 0) {
+			DXG_ERR("dxgsharedresource_seal failed");
+			goto cleanup;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret < 0)
+		goto cleanup;
+
+	DXG_TRACE("Object FD: %x", object_fd);
+
+	tmp = (u64) object_fd;
+
+	ret = copy_to_user(args.shared_handle, &tmp, sizeof(u64));
+	if (ret < 0)
+		DXG_ERR("failed to copy shared handle");
+
+cleanup:
+	if (ret < 0) {
+		if (object_fd >= 0)
+			put_unused_fd(object_fd);
+	}
+
+	if (handles)
+		vfree(handles);
+
+	if (syncobj)
+		kref_put(&syncobj->syncobj_kref, dxgsyncobject_release);
+
+	if (resource)
+		kref_put(&resource->resource_kref, dxgresource_release);
+
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_query_resource_info_nt(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_queryresourceinfofromnthandle args;
+	int ret;
+	struct dxgdevice *device = NULL;
+	struct dxgsharedresource *shared_resource = NULL;
+	struct file *file = NULL;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	file = fget(args.nt_handle);
+	if (!file) {
+		DXG_ERR("failed to get file from handle: %llx",
+			args.nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (file->f_op != &dxg_resource_fops) {
+		DXG_ERR("invalid fd: %llx", args.nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	shared_resource = file->private_data;
+	if (shared_resource == NULL) {
+		DXG_ERR("invalid private data: %llx", args.nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgdevice_acquire_lock_shared(device);
+	if (ret < 0) {
+		kref_put(&device->device_kref, dxgdevice_release);
+		device = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgsharedresource_seal(shared_resource);
+	if (ret < 0)
+		goto cleanup;
+
+	args.private_runtime_data_size =
+	    shared_resource->runtime_private_data_size;
+	args.resource_priv_drv_data_size =
+	    shared_resource->resource_private_data_size;
+	args.allocation_count = shared_resource->allocation_count;
+	args.total_priv_drv_data_size =
+	    shared_resource->alloc_private_data_size;
+
+	ret = copy_to_user(inargs, &args, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy output args");
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	if (file)
+		fput(file);
+	if (device)
+		dxgdevice_release_lock_shared(device);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+assign_resource_handles(struct dxgprocess *process,
+			struct dxgsharedresource *shared_resource,
+			struct d3dkmt_openresourcefromnthandle *args,
+			struct d3dkmthandle resource_handle,
+			struct dxgresource *resource,
+			struct dxgallocation **allocs,
+			struct d3dkmthandle *handles)
+{
+	int ret;
+	int i;
+	u8 *cur_priv_data;
+	u32 total_priv_data_size = 0;
+	struct d3dddi_openallocationinfo2 open_alloc_info = { };
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	ret = hmgrtable_assign_handle(&process->handle_table, resource,
+				      HMGRENTRY_TYPE_DXGRESOURCE,
+				      resource_handle);
+	if (ret < 0)
+		goto cleanup;
+	resource->handle = resource_handle;
+	resource->handle_valid = 1;
+	cur_priv_data = args->total_priv_drv_data;
+	for (i = 0; i < args->allocation_count; i++) {
+		ret = hmgrtable_assign_handle(&process->handle_table, allocs[i],
+					      HMGRENTRY_TYPE_DXGALLOCATION,
+					      handles[i]);
+		if (ret < 0)
+			goto cleanup;
+		allocs[i]->alloc_handle = handles[i];
+		allocs[i]->handle_valid = 1;
+		open_alloc_info.allocation = handles[i];
+		if (shared_resource->alloc_private_data_sizes)
+			open_alloc_info.priv_drv_data_size =
+			    shared_resource->alloc_private_data_sizes[i];
+		else
+			open_alloc_info.priv_drv_data_size = 0;
+
+		total_priv_data_size += open_alloc_info.priv_drv_data_size;
+		open_alloc_info.priv_drv_data = cur_priv_data;
+		cur_priv_data += open_alloc_info.priv_drv_data_size;
+
+		ret = copy_to_user(&args->open_alloc_info[i],
+				   &open_alloc_info,
+				   sizeof(open_alloc_info));
+		if (ret) {
+			DXG_ERR("failed to copy alloc info");
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+	args->total_priv_drv_data_size = total_priv_data_size;
+cleanup:
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+	if (ret < 0) {
+		for (i = 0; i < args->allocation_count; i++)
+			dxgallocation_free_handle(allocs[i]);
+		dxgresource_free_handle(resource);
+	}
+	return ret;
+}
+
+static int
+open_resource(struct dxgprocess *process,
+	      struct d3dkmt_openresourcefromnthandle *args,
+	      __user struct d3dkmthandle *res_out,
+	      __user u32 *total_driver_data_size_out)
+{
+	int ret = 0;
+	int i;
+	struct d3dkmthandle *alloc_handles = NULL;
+	int alloc_handles_size = sizeof(struct d3dkmthandle) *
+				 args->allocation_count;
+	struct dxgsharedresource *shared_resource = NULL;
+	struct dxgresource *resource = NULL;
+	struct dxgallocation **allocs = NULL;
+	struct d3dkmthandle global_share = {};
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dkmthandle resource_handle = {};
+	struct file *file = NULL;
+
+	DXG_TRACE("Opening resource handle: %llx", args->nt_handle);
+
+	file = fget(args->nt_handle);
+	if (!file) {
+		DXG_ERR("failed to get file from handle: %llx",
+			args->nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	if (file->f_op != &dxg_resource_fops) {
+		DXG_ERR("invalid fd type: %llx", args->nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	shared_resource = file->private_data;
+	if (shared_resource == NULL) {
+		DXG_ERR("invalid private data: %llx", args->nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	if (kref_get_unless_zero(&shared_resource->sresource_kref) == 0)
+		shared_resource = NULL;
+	else
+		global_share = shared_resource->host_shared_handle_nt;
+
+	if (shared_resource == NULL) {
+		DXG_ERR("Invalid shared resource handle: %x",
+			(u32)args->nt_handle);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	DXG_TRACE("Shared resource: %p %x", shared_resource,
+		global_share.v);
+
+	device = dxgprocess_device_by_handle(process, args->device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgdevice_acquire_lock_shared(device);
+	if (ret < 0) {
+		kref_put(&device->device_kref, dxgdevice_release);
+		device = NULL;
+		goto cleanup;
+	}
+
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgsharedresource_seal(shared_resource);
+	if (ret < 0)
+		goto cleanup;
+
+	if (args->allocation_count != shared_resource->allocation_count ||
+	    args->private_runtime_data_size <
+	    shared_resource->runtime_private_data_size ||
+	    args->resource_priv_drv_data_size <
+	    shared_resource->resource_private_data_size ||
+	    args->total_priv_drv_data_size <
+	    shared_resource->alloc_private_data_size) {
+		ret = -EINVAL;
+		DXG_ERR("Invalid data sizes");
+		goto cleanup;
+	}
+
+	alloc_handles = vzalloc(alloc_handles_size);
+	if (alloc_handles == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	allocs = vzalloc(sizeof(void *) * args->allocation_count);
+	if (allocs == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	resource = dxgresource_create(device);
+	if (resource == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	dxgsharedresource_add_resource(shared_resource, resource);
+
+	for (i = 0; i < args->allocation_count; i++) {
+		allocs[i] = dxgallocation_create(process);
+		if (allocs[i] == NULL)
+			goto cleanup;
+		ret = dxgresource_add_alloc(resource, allocs[i]);
+		if (ret < 0)
+			goto cleanup;
+	}
+
+	ret = dxgvmb_send_open_resource(process, adapter,
+					device->handle, global_share,
+					args->allocation_count,
+					args->total_priv_drv_data_size,
+					&resource_handle, alloc_handles);
+	if (ret < 0) {
+		DXG_ERR("dxgvmb_send_open_resource failed");
+		goto cleanup;
+	}
+
+	if (shared_resource->runtime_private_data_size) {
+		ret = copy_to_user(args->private_runtime_data,
+				shared_resource->runtime_private_data,
+				shared_resource->runtime_private_data_size);
+		if (ret) {
+			DXG_ERR("failed to copy runtime data");
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
+	if (shared_resource->resource_private_data_size) {
+		ret = copy_to_user(args->resource_priv_drv_data,
+				shared_resource->resource_private_data,
+				shared_resource->resource_private_data_size);
+		if (ret) {
+			DXG_ERR("failed to copy resource data");
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
+	if (shared_resource->alloc_private_data_size) {
+		ret = copy_to_user(args->total_priv_drv_data,
+				shared_resource->alloc_private_data,
+				shared_resource->alloc_private_data_size);
+		if (ret) {
+			DXG_ERR("failed to copy alloc data");
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
+	ret = assign_resource_handles(process, shared_resource, args,
+				      resource_handle, resource, allocs,
+				      alloc_handles);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(res_out, &resource_handle,
+			   sizeof(struct d3dkmthandle));
+	if (ret) {
+		DXG_ERR("failed to copy resource handle to user");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = copy_to_user(total_driver_data_size_out,
+			   &args->total_priv_drv_data_size, sizeof(u32));
+	if (ret) {
+		DXG_ERR("failed to copy total driver data size");
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	if (ret < 0) {
+		if (resource_handle.v) {
+			struct d3dkmt_destroyallocation2 tmp = { };
+
+			tmp.flags.assume_not_in_use = 1;
+			tmp.device = args->device;
+			tmp.resource = resource_handle;
+			ret = dxgvmb_send_destroy_allocation(process, device,
+							     &tmp, NULL);
+		}
+		if (resource)
+			dxgresource_destroy(resource);
+	}
+
+	if (file)
+		fput(file);
+	if (allocs)
+		vfree(allocs);
+	if (shared_resource)
+		kref_put(&shared_resource->sresource_kref,
+			 dxgsharedresource_destroy);
+	if (alloc_handles)
+		vfree(alloc_handles);
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		dxgdevice_release_lock_shared(device);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	return ret;
+}
+
+static int
+dxgkio_open_resource_nt(struct dxgprocess *process,
+				      void *__user inargs)
+{
+	struct d3dkmt_openresourcefromnthandle args;
+	struct d3dkmt_openresourcefromnthandle *__user args_user = inargs;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = open_resource(process, &args,
+			    &args_user->resource,
+			    &args_user->total_priv_drv_data_size);
+
+cleanup:
+
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
 static struct ioctl_desc ioctls[] = {
 /* 0x00 */	{},
 /* 0x01 */	{dxgkio_open_adapter_from_luid, LX_DXOPENADAPTERFROMLUID},
@@ -2215,10 +2998,11 @@ static struct ioctl_desc ioctls[] = {
 /* 0x3c */	{},
 /* 0x3d */	{},
 /* 0x3e */	{dxgkio_enum_adapters3, LX_DXENUMADAPTERS3},
-/* 0x3f */	{},
+/* 0x3f */	{dxgkio_share_objects, LX_DXSHAREOBJECTS},
 /* 0x40 */	{},
-/* 0x41 */	{},
-/* 0x42 */	{},
+/* 0x41 */	{dxgkio_query_resource_info_nt,
+		 LX_DXQUERYRESOURCEINFOFROMNTHANDLE},
+/* 0x42 */	{dxgkio_open_resource_nt, LX_DXOPENRESOURCEFROMNTHANDLE},
 /* 0x43 */	{},
 /* 0x44 */	{},
 /* 0x45 */	{},
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 39055b0c1069..f74564cf7ee9 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -682,6 +682,94 @@ enum d3dkmt_deviceexecution_state {
 	_D3DKMT_DEVICEEXECUTION_ERROR_DMAPAGEFAULT	= 7,
 };
 
+struct d3dddi_openallocationinfo2 {
+	struct d3dkmthandle	allocation;
+#ifdef __KERNEL__
+	void			*priv_drv_data;
+#else
+	__u64			priv_drv_data;
+#endif
+	__u32			priv_drv_data_size;
+	__u64			gpu_va;
+	__u64			reserved[6];
+};
+
+struct d3dkmt_openresourcefromnthandle {
+	struct d3dkmthandle	device;
+	__u32			reserved;
+	__u64			nt_handle;
+	__u32			allocation_count;
+	__u32			reserved1;
+#ifdef __KERNEL__
+	struct d3dddi_openallocationinfo2 *open_alloc_info;
+#else
+	__u64			open_alloc_info;
+#endif
+	int			private_runtime_data_size;
+	__u32			reserved2;
+#ifdef __KERNEL__
+	void			*private_runtime_data;
+#else
+	__u64			private_runtime_data;
+#endif
+	__u32			resource_priv_drv_data_size;
+	__u32			reserved3;
+#ifdef __KERNEL__
+	void			*resource_priv_drv_data;
+#else
+	__u64			resource_priv_drv_data;
+#endif
+	__u32			total_priv_drv_data_size;
+#ifdef __KERNEL__
+	void			*total_priv_drv_data;
+#else
+	__u64			total_priv_drv_data;
+#endif
+	struct d3dkmthandle	resource;
+	struct d3dkmthandle	keyed_mutex;
+#ifdef __KERNEL__
+	void			*keyed_mutex_private_data;
+#else
+	__u64			keyed_mutex_private_data;
+#endif
+	__u32			keyed_mutex_private_data_size;
+	struct d3dkmthandle	sync_object;
+};
+
+struct d3dkmt_queryresourceinfofromnthandle {
+	struct d3dkmthandle	device;
+	__u32			reserved;
+	__u64			nt_handle;
+#ifdef __KERNEL__
+	void			*private_runtime_data;
+#else
+	__u64			private_runtime_data;
+#endif
+	__u32			private_runtime_data_size;
+	__u32			total_priv_drv_data_size;
+	__u32			resource_priv_drv_data_size;
+	__u32			allocation_count;
+};
+
+struct d3dkmt_shareobjects {
+	__u32			object_count;
+	__u32			reserved;
+#ifdef __KERNEL__
+	const struct d3dkmthandle *objects;
+	void			*object_attr;	/* security attributes */
+#else
+	__u64			objects;
+	__u64			object_attr;
+#endif
+	__u32			desired_access;
+	__u32			reserved1;
+#ifdef __KERNEL__
+	__u64			*shared_handle;	/* output file descriptors */
+#else
+	__u64			shared_handle;
+#endif
+};
+
 union d3dkmt_enumadapters_filter {
 	struct {
 		__u64	include_compute_only:1;
@@ -747,5 +835,13 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x3b, struct d3dkmt_waitforsynchronizationobjectfromgpu)
 #define LX_DXENUMADAPTERS3		\
 	_IOWR(0x47, 0x3e, struct d3dkmt_enumadapters3)
+#define LX_DXSHAREOBJECTS		\
+	_IOWR(0x47, 0x3f, struct d3dkmt_shareobjects)
+#define LX_DXOPENSYNCOBJECTFROMNTHANDLE2 \
+	_IOWR(0x47, 0x40, struct d3dkmt_opensyncobjectfromnthandle2)
+#define LX_DXQUERYRESOURCEINFOFROMNTHANDLE \
+	_IOWR(0x47, 0x41, struct d3dkmt_queryresourceinfofromnthandle)
+#define LX_DXOPENRESOURCEFROMNTHANDLE	\
+	_IOWR(0x47, 0x42, struct d3dkmt_openresourcefromnthandle)
 
 #endif /* _D3DKMTHK_H */

